import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/google_map_poly_lines_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/api_responses/ride_details_response.dart';
import 'package:one_ride_user/models/api_responses/ride_request_update_socket_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/select_payment_method_bottomSheet.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/submit_review_bottomSheet.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class AcceptedRequestScreenController extends GetxController {
  SelectPaymentOptionModel getValues = SelectPaymentOptionModel();
  String otp = '';
  String value = '';
  AcceptedRequestScreenParameter? screenParameter;
  // late SocketController homeSocketScreenController;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  // List<LatLng> nearestCars = [];
  List<NearestCarsListRide> rides = [];
  // bool chainRequest = false;
  List<NearestCarsListCategory> categories = [];

  NearestCarsListRide? selectedRide;
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  String rideId = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  RideHistoryStatus ridePostAcceptanceStatus = RideHistoryStatus.accepted;

  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  // double zoomLevel = 12;
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;

  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    RideRequestUpdateSocketResponse? response =
        RideRequestUpdateSocketResponse.fromJson(data);
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen, arguments: response.ride);
    } else {
      rideAccepted.value = false;
      Get.back();
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  void computeCentroid(List<LocationModel> points) {
    double latitude = 0;
    double longitude = 0;
    LocationModel eastMost = LocationModel(latitude: 0, longitude: -180);
    LocationModel westMost = LocationModel(latitude: 0, longitude: 180);
    LocationModel northMost = LocationModel(latitude: -180, longitude: 0);
    LocationModel southMost = LocationModel(latitude: 180, longitude: 0);

    for (LocationModel point in points) {
      if (point.longitude > eastMost.longitude) {
        eastMost = point;
      }
      if (point.longitude < westMost.longitude) {
        westMost = point;
      }
      if (point.latitude > northMost.latitude) {
        northMost = point;
      }
      if (point.latitude < southMost.latitude) {
        southMost = point;
      }
    }
    log('EastMost: ${eastMost.longitude}\nWestMost: ${westMost.longitude}\nNorthMost: ${northMost.latitude}\nSouthMost: ${southMost.latitude}');
    latitude = ((northMost.latitude + southMost.latitude) / 2);
    longitude = ((eastMost.longitude + westMost.longitude) / 2);
    log('Centroid:\nLatitude: ${latitude}  Longitude: ${longitude}');

    final bound = boundsFromLatLngList([
      LatLng(eastMost.latitude, eastMost.longitude),
      LatLng(westMost.latitude, westMost.longitude),
      LatLng(southMost.latitude, southMost.longitude),
      LatLng(northMost.latitude, northMost.longitude)
    ]);

    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  onResetListButtonTap() {
    selectedRide = null;
    update();
    getList();
  }

  void getNearestCarsList() {
    getList();
  }

  Future<void> getList() async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingNearestCarsList(response);
  }

  void onSuccessRetrievingNearestCarsList(NearestCarsListResponse response) {
    rides = response.data.rides;
    categories = response.data.categories;
    update();
    updateNearestCarsList();
    log('Nearest cars list fetched successfully!');
    return;
  }

  void onCategoryClick(String categoryId) async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText:
            AppLanguageTranslation.sendBatchRequestTransKey.toCurrentLanguage,
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool) {
      doActionForCategoryClick(categoryId, res);
    }
  }

  Future<void> doActionForCategoryClick(
      String categoryId, bool runBatchRequests) async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0,
        categoryId: categoryId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingCategoryWiseVehicles(response, runBatchRequests);
  }

  onSuccessGettingCategoryWiseVehicles(
      NearestCarsListResponse response, bool runBatchRequests) {
    rides = response.data.rides;
    selectedRide = null;
    update();
    updateNearestCarsList();
    if (runBatchRequests) {
      sendBatchRideRequests();
    }
  }

  void updateNearestCarsList() {
    googleMapMarkers.clear();
    _addPickUpAndDropMarkers();
    for (final (int, NearestCarsListRide) singleRide in rides.indexed) {
      singleRide.$1;
      BitmapDescriptor icon;
      // if(singleRide.vehicle.category == 'car'){icon = }
      icon = nearestCarIcon!;
      googleMapMarkers.add(Marker(
          markerId: MarkerId('nearestCar-${singleRide.$1}'),
          position:
              LatLng(singleRide.$2.location.lat, singleRide.$2.location.lng),
          icon: icon));
    }
    update();
  }

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      // chainRequest = true;
      update();
      onBottomButtonTap(showDialogue: false);
    }
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.sentDriverRequestTransKey.toCurrentLanguage);
    await Future.delayed(const Duration(seconds: 10));
    AppDialogs.showErrorDialog(
        messageText: AppLanguageTranslation
            .notAcceptDriverRequestTransKey.toCurrentLanguage);
    selectedRide = null;
    update();
  }

  void onRideTap(NearestCarsListRide theRide) async {
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  void onSelectPaymentmethod({bool showDialogue = true}) async {
    final value = await Get.bottomSheet(const SelectPaymentMethodBottomsheet());
    if (value is SelectPaymentOptionModel) {
      getValues = value;
    }
    update();
  }

  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };
    if (ridePostAcceptanceStatus.stringValue ==
        RideHistoryStatus.accepted.stringValue) {
      dynamic res =
          await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
      if (res is String) {
        reason = res;
        update();

        requestBody['status'] = 'cancelled';
        requestBody['cancel_reason'] = reason;
        cancelRide(requestBody);
      }
    }
    log(reason);
    log(ridePostAcceptanceStatus.stringValueForView);
  }

  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    Get.back();
    Get.back();
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.cancelRideRequestTransKey.toCurrentLanguage);
  }

  //------------post start method---------------
  Future<void> onPaymentTap() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'method': getValues.value,
    };
    RawAPIResponse? response = await APIRepo.onPaymentTap(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    getValues.value == 'paypal'
        ? _onSucessPaymentStatus(response)
        : _onSucessWalletPaymentStatus(response);
  }

  _onSucessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();
    Get.offAllNamed(AppPageNames.homeNavigatorScreen, arguments: 2);
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    Get.offAllNamed(AppPageNames.homeNavigatorScreen, arguments: 2);
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    otp = response.data.otp;
    rideDetails = response.data;
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is AcceptedRequestScreenParameter) {
      screenParameter = params;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      update();
      if (rideId.isNotEmpty) {
        getRideDetails();
      }
    }
  }

  void submitReview() {
    Get.bottomSheet(SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments:
                SubmitReviewScreenParameter(id: rideDetails.id, type: 'ride')));
  }

  Future<void> getPolyLines(
      /* Set<Polyline> googleMapPolyLines, */ double orLat,
      double orLong,
      double tarLat,
      double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noPolylineFoundRequestTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(
          AppLanguageTranslation.errorHappenedTransKey.toCurrentLanguage);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPolyLines(response);
  }

  onSuccessRetrievingPolyLines(GoogleMapPolyLinesResponse response) {
    List<PolyLinesStep> steps =
        response.routes.firstOrNull?.legs.firstOrNull?.steps ?? [];
    List<LatLng> pointLatLngs = [];
    for (var step in steps) {
      pointLatLngs.add(LatLng(step.startLocation.lat, step.startLocation.lng));
      pointLatLngs.add(LatLng(step.endLocation.lat, step.endLocation.lng));
      polyLinePoints.add(LocationModel(
          latitude: step.startLocation.lat, longitude: step.startLocation.lng));
    }
    polyLinePoints.add(LocationModel(
        latitude: dropLocation!.latitude, longitude: dropLocation!.longitude));

    googleMapPolyLines.add(Polyline(
        polylineId: PolylineId('thePolyLine'),
        color: Colors.teal,
        width: 3,
        points: pointLatLngs)); // Use pointLatLngs here
    computeCentroid(
        polyLinePoints); // Keep this if you still need to compute the centroid
    update(); // Update the UI
  }

  _addPickUpAndDropMarkers() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? pickIcon =
        await getBytesFromAsset(AppAssetImages.pickupMarkerPngIcon, aspectSize);

    if (pickIcon != null) {
      pickUpIcon = BitmapDescriptor.fromBytes(pickIcon);
    }
    final Uint8List? dropIcon =
        await getBytesFromAsset(AppAssetImages.dropMarkerPngIcon, aspectSize);

    if (dropIcon != null) {
      dropUpIcon = BitmapDescriptor.fromBytes(dropIcon);
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();

    getPolyLines(
        // googleMapPolyLines,
        pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude);
    update();
  }

//===============for icon ============
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
  //============icon elements end===========

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();

    final Uint8List? markerIcon =
        await getBytesFromAsset(AppAssetImages.nearestCar, aspectSize);

    if (markerIcon != null) {
      nearestCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    update();
  }

  dynamic onRideRequestStatusUpdate(dynamic data) async {
    if (data is RideDetailsData) {
      rideDetails = data;
      update();
      ridePostAcceptanceStatus =
          RideHistoryStatus.toEnumValue(rideDetails.status);
      update();
      AppDialogs.showSuccessDialog(
          messageText:
              '${AppLanguageTranslation.rideHasBeenTransKey.toCurrentLanguage} ${ridePostAcceptanceStatus.stringValueForView}!');
    }
    log('Ride is updated!');
  }

  StreamSubscription<RideDetailsData>? listen;
  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketScreenController = Get.find<SocketController>();

    listen = socketScreenController.rideDetails.listen((p0) {
      onRideRequestStatusUpdate(p0);
    });
    createCarsLocationIcon();
    getNearestCarsList();

    _assignParameters();

    super.onInit();
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}

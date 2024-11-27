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
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/submit_otp_screen_bottomsheet.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PullingOfferDetailsScreenController extends GetxController {
  int totalseat = 0;
  String otp = '';
  RxBool pickUpPassengers = false.obs;
  late SocketController homeSocketScreenController;
  LocationModel pickupLocation = LocationModel.empty();
  LocationModel dropLocation = LocationModel.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  String type = 'passenger';
  PullingOfferDetailsData offerDetails = PullingOfferDetailsData.empty();
  List<PullingOfferDetailsRequest> requests = [];
  PullingOfferDetailsPayment requestPayment = PullingOfferDetailsPayment();
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();

  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;

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

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
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

  void onStartRideButtonTap() {
    pickUpPassengers.value = true;
    update();
    getRequestDetails();
    log(offerDetails.status);
    // Get.bottomSheet(RequestRideBottomsheet(),
    //     settings: RouteSettings(
    //       arguments: OfferOverViewBottomsheetScreenParameters(
    //           requestDetails: requestDetails, type: type, seat: totalseat),
    //     ),
    //     isScrollControlled: true);
  }

  void onStartTripTap() {
    onPickupButtonTap(offerDetails.requests.firstOrNull ??
        PullingOfferDetailsRequest.empty());
    getRequestDetails();
  }

  void onCompleteRideButtonTap() {
    /* if (offerDetails.type == 'passenger') {
      dropPassenger(offerDetails.requests.firstOrNull ??
          PullingOfferDetailsRequest.empty());
    } */
    completeRide();
  }

  void onMakePaymentTap() async {
    await AppDialogs.showConfirmPaymentDialog(
        amount: offerDetails.requests.firstOrNull?.rate ??
            offerDetails.rate * offerDetails.seats.toDouble(),
        symbol: offerDetails.requests.firstOrNull?.currency.symbol ??
            offerDetails.currency.symbol,
        titleText: AppLanguageTranslation
            .paymentConfirmationTransKey.toCurrentLanguage,
        totalAmount: offerDetails.requests.firstOrNull?.rate ??
            offerDetails.rate * offerDetails.seats.toDouble(),
        noButtonText: AppLanguageTranslation.cancelTransKey.toCurrentLanguage,
        yesButtonText:
            AppLanguageTranslation.confirmToPayTransKey.toCurrentLanguage,
        onYesTap: () async {
          await Get.toNamed(AppPageNames.selectPaymentMethodsScreen,
              arguments: offerDetails.requests.firstOrNull?.id);
        },
        onNoTap: () {
          Get.back();
        });

    /* dynamic res = await Get.toNamed(AppPageNames.makePaymentScreen,
        arguments: offerDetails.type == 'passenger'
            ? offerDetails.requests.firstOrNull?.id
            : offerDetails.id);
    if (res is bool && res) {
      completeRide();
      return;
    }
    AppDialogs.showErrorDialog(
        messageText: 'Please Make payment to complete this Trip!'); */
  }

  Future<void> completeRide() async {
    RawAPIResponse? response = await APIRepo.completeRide(offerDetails.id);
    if (response == null) {
      log('No response for completing ride!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCompletingRide(response);
  }

  onSuccessCompletingRide(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  void onPickupButtonTap(PullingOfferDetailsRequest request,
      {PullingOfferDetailsPayment? payment}) async {
    log('$requestId got Tapped!');
    if (request.status == 'accepted' && offerDetails.type == 'passenger') {
      pickUpPassengers.value = true;
      update();
      getRequestDetails();
      dynamic res = await Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
          settings: RouteSettings(arguments: request));
      if (res is bool && res) {
        getRequestDetails();
      }
    } else if (request.status == 'accepted') {
      dynamic res = await Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
          settings: RouteSettings(arguments: request));
      if (res is bool && res) {
        getRequestDetails();
      }
    } else if (request.status == 'started') {
      if (payment!.transactionId.isNotEmpty) {
        dropPassenger(request);
      } else {
        Get.snackbar(
          'Waiting for payment',
          'Your Co-passenger\'s have not payment yet',
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          backgroundColor: AppColors.alertColor.withOpacity(0.4),
          colorText: Colors.black,
        );
      }
      if (offerDetails.type == 'passenger') {
        completeRide();
      }
    } else if (offerDetails.type == 'passenger' &&
        request.status == 'completed') {
      completeRide();
    }
    getRequestDetails();
  }

  Future<void> dropPassenger(PullingOfferDetailsRequest request) async {
    final Map<String, dynamic> requestBody = {
      '_id': request.id,
      'status': 'completed'
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      log('No response for Dropping Passenger!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessDroppingPassenger(response);
  }

  onSuccessDroppingPassenger(RawAPIResponse response) {
    getRequestDetails();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> getRequestDetails() async {
    PullingOfferDetailsResponse? response =
        await APIRepo.getPullingOfferDetails(requestId);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PullingOfferDetailsResponse response) {
    offerDetails = response.data;
    requests = response.data.requests;
    update();
    _assignParameters();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is OfferOverViewScreenParameters) {
      requestId = params.id;
      type = params.type;
      totalseat = params.seat;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    } else if (params is String) {
      requestId = params;
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
      update();
    }
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

  onSuccessRetrievingPolyLines(
      /* Set<Polyline> googleMapPolyLines, */ GoogleMapPolyLinesResponse
          response) {
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
        latitude: dropLocation.latitude, longitude: dropLocation.longitude));
    // cameraPosition = computeCentroid(polyLinePoints);
    // maxDistance = computeMaxDistance(polyLinePoints, cameraPosition);
    // zoomLevel = getZoomLevel(maxDistance);
    // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //         target: LatLng(
    //             cameraPosition.latitude - 0.03, cameraPosition.longitude),
    //         zoom: zoomLevel)));
    googleMapPolyLines.add(Polyline(
        polylineId: const PolylineId('thePolyLine'),
        color: Colors.teal,
        width: 3,
        points: pointLatLngs));
    computeCentroid(polyLinePoints);
    update();
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
        position: LatLng(pickupLocation.latitude, pickupLocation.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation.latitude, dropLocation.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    pickupLocation = LocationModel(
        address: offerDetails.from.address,
        latitude: offerDetails.from.location.lat,
        longitude: offerDetails.from.location.lng);
    dropLocation = LocationModel(
        latitude: offerDetails.to.location.lat,
        longitude: offerDetails.to.location.lng,
        address: offerDetails.to.address);
    update();
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation.latitude,
        pickupLocation.longitude,
        dropLocation.latitude,
        dropLocation.longitude);
    update();
  }

  void createCarsLocationIcon() async {
    nearestCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestCar);
    nearestMotorCycleIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestMotorCycle);
    update();
  }

  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        Helper.showSnackBar(
            AppLanguageTranslation.yourOfferRequestTransKey.toCurrentLanguage);
      }
    }
  }

  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        if (requestId == requestStatusSocketResponse.request) {
          getRequestDetails();
        }
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;
  @override
  void onInit() {
    _getScreenParameters();

    SocketController socketController = Get.find<SocketController>();

    listen = socketController.pullingRequestResponseData.listen((p0) {});
    listen?.onData((data) {
      onNewPullingRequest(data);
    });
    listen2 = socketController.pullingRequestStatusResponseData.listen((p0) {});
    listen2?.onData((data) {
      onPullingRequestStatusUpdate(data);
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void popScope() {
    listen?.cancel();
    listen2?.cancel();
  }

  @override
  void onClose() {
    dispose();
    listen?.cancel();
    listen2?.cancel();
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

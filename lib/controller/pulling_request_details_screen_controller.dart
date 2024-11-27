import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/google_map_poly_lines_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_details_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/submit_review_bottomSheet.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PullingRequestDetailsScreenController extends GetxController {
  String test = 'screen controller is connected!';
  int totalSeat = 0;
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
  PullingRequestDetailsData requestDetails = PullingRequestDetailsData.empty();
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
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();

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

  void onMakePaymentTap() async {
    await AppDialogs.showConfirmPaymentDialog(
        amount: requestDetails.rate * requestDetails.seats.toDouble(),
        symbol: requestDetails.currency.symbol,
        titleText: AppLanguageTranslation
            .paymentConfirmationTransKey.toCurrentLanguage,
        totalAmount: requestDetails.rate * requestDetails.seats.toDouble(),
        noButtonText: AppLanguageTranslation.cancelTransKey.toCurrentLanguage,
        yesButtonText:
            AppLanguageTranslation.confirmToPayTransKey.toCurrentLanguage,
        onYesTap: () async {
          await Get.toNamed(AppPageNames.selectPaymentMethodsScreen,
              arguments: requestDetails.id);
        },
        onNoTap: () {
          Get.back();
        });
    /* dynamic res = await Get.toNamed(AppPageNames.makePaymentScreen,
        arguments: requestDetails.id);
    if (res is bool && res) {
      AppDialogs.showSuccessDialog(messageText: 'Payment succeeded!');
      return;
    }
    AppDialogs.showErrorDialog(
        messageText: 'You need to make payment to complete this trip!'); */
  }

  void reviewButtonTap() {
    Get.bottomSheet(SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments: SubmitReviewScreenParameter(
                id: requestDetails.id, type: 'pulling_request')));
  }

  void onCancelTripButtonTap() async {
    log('Cancel Button got Tapped!');
    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      cancelRide(res);
    }
    getRequestDetails();
  }

  Future<void> cancelRide(String reason) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'cancelled', reason: reason);
    if (response == null) {
      Helper.showSnackBar(
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
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.cancelRideRequestTransKey.toCurrentLanguage);
    getRequestDetails();
  }

  Future<void> getRequestDetails() async {
    PullingRequestDetailsResponse? response =
        await APIRepo.getPullingRequestDetails(requestId);
    if (response == null) {
      Helper.showSnackBar(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PullingRequestDetailsResponse response) {
    requestDetails = response.data;
    otp = requestDetails.otp;
    update();
    _assignParameters();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      requestId = params;
      // type = params.type;
      // totalSeat = params.seat;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
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
        address: requestDetails.offer.from.address,
        latitude: requestDetails.offer.from.location.lat,
        longitude: requestDetails.offer.from.location.lng);
    dropLocation = LocationModel(
        latitude: requestDetails.offer.to.location.lat,
        longitude: requestDetails.offer.to.location.lng,
        address: requestDetails.offer.to.address);
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
        // AppDialogs.showSuccessDialog(
        //     messageText: 'Your Request has an update. Please Check it.');
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;

  @override
  void onInit() {
    _getScreenParameters();

    SocketController socketController = Get.find<SocketController>();

    if (listen == null) {
      listen = socketController.pullingRequestResponseData.listen((p0) {});
      listen?.onData((data) {
        onNewPullingRequest(data);
      });
    }
    if (listen2 == null) {
      listen2 =
          socketController.pullingRequestStatusResponseData.listen((p0) {});
      listen2?.onData((data) {
        onPullingRequestStatusUpdate(data);
      });
    }
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

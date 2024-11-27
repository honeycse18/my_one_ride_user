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
import 'package:one_ride_user/models/api_responses/ride_request_update_socket_response.dart';
import 'package:one_ride_user/models/api_responses/schedule_ride_post_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/select_car_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class SelectCarScreenController extends GetxController {
  String testing = 'Select car screen controller.';
  SelectCarScreenParameter? screenParameter;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  bool isScheduleRide = false;
  // List<LatLng> nearestCars = [];
  List<NearestCarsListRide> rides = [];
  RxBool barrierDismissible = false.obs;
  // bool chainRequest = false;
  List<NearestCarsListCategory> categories = [];
  NearestCarsListRide? selectedRide;
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  ScheduleRideData rideRequest = ScheduleRideData.empty();
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  // late SocketController homeSocketScreenController;

  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;

  var selectedBookingDate = DateTime.now().obs;
  var selectedBookingTime = TimeOfDay.now().obs;

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
    // googleMapControllerCompleter.complete(controller);
    /* LatLngBounds;
    final bound = boundsFromLatLngList([
      LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
      LatLng(dropLocation!.latitude, dropLocation!.longitude)
    ]);
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 15));
    } */
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
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  String formatDateTime(DateTime date, TimeOfDay time) {
    DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
  }

  void updateSelectedStartDate(DateTime newDate) {
    selectedBookingDate.value = newDate;
    log(selectedBookingDate.value.toString());
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedBookingTime.value = newTime;
    log(selectedBookingTime.value.toString());
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
      APIHelper.onError(AppLanguageTranslation
          .noResponseNearestCarTransKey.toCurrentLanguage);
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
    // log('Cars Location List: ${nearestCars.toString()}');
    // for (int i = 0; i < nearestCars.length; i++) {
    //   LatLng carLocation = nearestCars[i];
    //   googleMapMarkers.add(Marker(
    //       markerId: MarkerId('nearestCar-$i'),
    //       position: LatLng(carLocation.latitude, carLocation.longitude),
    //       icon: nearestMotorCycleIcon!));
    // }
  }

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      // chainRequest = true;
      update();
      onRideNowButtonTap(showDialogue: false);
      /* if (!chainRequest) {
        AppDialogs.showErrorDialog(messageText: 'Chain is broken!');
        selectedRide = null;
        update();
        return;
      } */
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
    /* if (chainRequest) {
      dynamic res = await AppDialogs.showConfirmDialog(
          messageText: 'Are you sure to break the chain request?',
          onYesTap: () async {
            Get.back(result: true);
          },
          shouldCloseDialogOnceYesTapped: false,
          onNoTap: () async {
            Get.back(result: false);
          });
      if (res is bool && !res) {
        return;
      }
    }
    chainRequest = false; */
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  void onRideNowButtonTap({bool showDialogue = true}) {
    final Map<String, dynamic> fromLocation = {
      'lat': pickupLocation!.latitude,
      'lng': pickupLocation!.longitude
    };
    final Map<String, dynamic> toLocation = {
      'lat': dropLocation!.latitude,
      'lng': dropLocation!.longitude
    };
    final Map<String, dynamic> from = {
      'address': pickupLocation?.address,
      'location': fromLocation
    };
    final Map<String, dynamic> to = {
      'address': dropLocation?.address,
      'location': toLocation
    };
    final Map<String, dynamic> requestBody = {
      'ride': selectedRide!.id,
      'from': from,
      'to': to
    };
    if (isScheduleRide) {
      requestBody['schedule'] = true;
      requestBody['date'] =
          formatDateTime(selectedBookingDate.value, selectedBookingTime.value);
    }

    requestRide(requestBody, showDialogue);
  }

  /* Future<void> requestScheduleRide(Map<String, dynamic> requestBody) async {
    ScheduleRideResponse? response =
        await APIRepo.scheduleRidePost(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: 'No response for this operation!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessScheduleBooking(response);
  }

  onSuccessScheduleBooking(ScheduleRideResponse response) {
    AppDialogs.showSuccessDialog(messageText: 'Success!');
  } */

  Future<void> requestRide(
      Map<String, dynamic> requestBody, bool showDialogue) async {
    // String requestBodyJson =0 jsonEncode(requestBody);
    ScheduleRideResponse? response = await APIRepo.requestForRide(requestBody);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseRideNowTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRequestingForRide(response, showDialogue);
  }

  onSuccessRequestingForRide(ScheduleRideResponse response, bool showDialogue) {
    // if (!chainRequest) {
    //   Get.back();
    //   Get.back();
    // }
    requestId = response.data.id;
    rideRequest = response.data;
    update();
    if (showDialogue) {
      AppDialogs.showActionableDialog(
        barrierDismissible: barrierDismissible.value,
        titleText: 'Request Ongoing',
        titleTextColor: AppColors.darkColor,
        messageText: 'Your Ride request is ongoing...',
        buttonText: 'Cancel Request',
        onTap: promptCancellation,
      );
    }
  }

  promptCancellation() async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: 'Are you sure to cancel ongoing request?',
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool && res) {
      cancelPendingRequest();
    }
  }

  Future<void> cancelPendingRequest() async {
    final Map<String, dynamic> requestBody = {
      '_id': requestId,
      'status': 'rejected'
    };
    RawAPIResponse? response = await APIRepo.cancelPendingRequest(requestBody);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseCallingPendingTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      barrierDismissible.value = true;
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /* double computeMaxDistance(List<LocationModel> points, LatLng centroid) {
    double maximumDistance = 0;
    for (LocationModel point in points) {
      double dx = centroid.latitude - point.latitude;
      double dy = centroid.longitude - point.longitude;
      double distance = math.sqrt(dx * dx + dy * dy);
      if (distance > maxDistance) {
        maximumDistance = distance;
      }
    }
    log('Maximum Distance: $maximumDistance');
    return maximumDistance;
  } */

  /* double logBase(num x, num base) => math.log(x) / math.log(base);

  double getZoomLevel(double maxDistance) {
    double screenWidth = Get.width;
    double distInMeters = maxDistance * 111139;
    zoomLevel = logBase((distInMeters / (distInMeters * 256)), 2) - 1;
    log('ScreenWidth: $screenWidth\nzoomLevel: $zoomLevel');
    zoomLevel = 13;
    return zoomLevel < 0 ? 1 : zoomLevel;
  } */

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectCarScreenParameter) {
      screenParameter = params;
      pickupLocation = screenParameter!.pickupLocation;
      dropLocation = screenParameter!.dropLocation;
      isScheduleRide = screenParameter?.isScheduleRide ?? false;
      update();
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
        latitude: dropLocation!.latitude, longitude: dropLocation!.longitude));
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
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    /* googleMapPolyLines.add(Polyline(
        polylineId: PolylineId('polyLineId'),
        color: Colors.blue,
        points: [
          LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
          LatLng(dropLocation!.latitude, dropLocation!.longitude),
        ],
        width: 5)); */
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude);
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
/* 
  void openBottomSheet(BuildContext context) {
    final bottomSheet = bottomSheetFormKey.currentState?.showBottomSheet<void>(
        (BuildContext context) {
      return DraggableScrollableSheet(
          expand: false, // Set to true if you want it to expand initially
          initialChildSize:
              0.5, // Initial size as a fraction of the screen height
          minChildSize: 0.3, // Minimum size as a fraction of the screen height
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.topLeft,
                decoration: const ShapeDecoration(
                    color: AppColors.mainBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    )),
                child: Column(
                  children: [
                    AppGaps.hGap10,
                    Container(
                      width: 60,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 3,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFA5A5A5),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: SelectCarBottomSheet(),
                    )),
                  ],
                ));
          });
    },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ));

    /* Get.bottomSheet(const SelectCarBottomSheet(),
        settings: RouteSettings(arguments: screenParameter)); */
  } */

/*   void getBottomsheetWithDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
    final context = Get.context;
    if (context != null) {
      // ignore: use_build_context_synchronously
      // openBottomSheet(context);
    }
  } */

  dynamic onRideRequestStatus(dynamic data) async {
    log('ride request status socket got trigerred!');
    RideRequestUpdateSocketResponse response =
        RideRequestUpdateSocketResponse();
    if (data is RideRequestUpdateSocketResponse) {
      response = data;
    }
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen,
          arguments: AcceptedRequestScreenParameter(
              rideId: response.ride,
              selectedCarScreenParameter: SelectCarScreenParameter(
                  pickupLocation: pickupLocation!,
                  dropLocation: dropLocation!)));
    } else {
      rideAccepted.value = false;
      Get.back();
      APIHelper.onFailure(AppLanguageTranslation
          .rejectPendingRequestTransKey.toCurrentLanguage);
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  StreamSubscription<RideRequestUpdateSocketResponse>? listen;

  @override
  void onInit() {
    SocketController socketScreenController = Get.find<SocketController>();
    listen = socketScreenController.rideRequestSocketResponse.listen(
      (p0) {
        onRideRequestStatus(p0);
      },
    );
    _getScreenParameters();
    createCarsLocationIcon();
    getNearestCarsList();
    _assignParameters();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    listen?.cancel();
    super.onClose();
  }

  /* @override
  void onClose() {
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  } */

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

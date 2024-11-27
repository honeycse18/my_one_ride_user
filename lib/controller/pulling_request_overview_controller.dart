import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/google_map_poly_lines_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/request_ride_bottomsheet_screen.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PullingRequestOverviewController extends GetxController {
  int totalseat = 0;
  String otp = '';
  late SocketController homeSocketScreenController;
  LocationModel pickupLocation = LocationModel.empty();
  LocationModel dropLocation = LocationModel.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  String type = 'passenger';
  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();

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
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;

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

  void onRequestRideButtonTap() {
    Get.bottomSheet(RequestRideBottomsheet(),
        settings: RouteSettings(
          arguments: OfferOverViewBottomsheetScreenParameters(
              requestDetails: requestDetails, type: type, seat: totalseat),
        ),
        isScrollControlled: true);
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
    requestDetails = response.data;
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
        address: requestDetails.from.address,
        latitude: requestDetails.from.location.lat,
        longitude: requestDetails.from.location.lng);
    dropLocation = LocationModel(
        latitude: requestDetails.to.location.lat,
        longitude: requestDetails.to.location.lng,
        address: requestDetails.to.address);
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

  @override
  void onInit() {
    _getScreenParameters();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
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

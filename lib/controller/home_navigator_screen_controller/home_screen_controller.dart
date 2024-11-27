import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class HomeScreenController extends GetxController {
  final PagingController<int, NearestDriverList> nearestDriverPagingController =
      PagingController(firstPageKey: 1);
  bool status = true;
  GoogleMapController? myMapController;
  final String userMarkerID = 'userID';
  final String markerID = 'markerID';
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  GoogleMapController? googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  GoogleMapController? mapController;
  LatLng myLatLng = const LatLng(0, 0);
  UserDetailsData userDetailsData = UserDetailsData.empty();

  List<RentCarListItem> rentCarList = [];
  List<NearestDriverList> nearestDriverList = [];

  BitmapDescriptor? myCarIcon;

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    // panelController.open();
  }

  late Location location;
  Rx<LatLng> userLocation = Rx<LatLng>(LatLng(0.0, 0.0));

  // Function to request location permission
  Future<void> _requestPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    try {
      final LocationData myCurrentLocation = await location.getLocation();
      myLatLng = LatLng(
        myCurrentLocation.latitude!,
        myCurrentLocation.longitude!,
      );
      userLocation.value = myLatLng;
      _focusLocation(
          latitude: myLatLng.latitude,
          longitude: myLatLng.longitude,
          showRiderLocation: true);

      // log('${userLocation.value}');
      log('${myLatLng.latitude}');
      return myCurrentLocation;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addTapMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    update();
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    final context = Get.context;
    if (context != null) {
      // final ImageConfiguration config = createLocalImageConfiguration(context);
      /* gpsIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.carGPSImage,
      ); */
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(markerID), position: latLng, icon: myCarIcon!));
  }

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? markerIcon = await getBytesFromAsset(
        AppAssetImages.selectedLocationPNGImage, aspectSize);
    // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon!), markerId: MarkerId(markerID),);
    if (markerIcon != null) {
      myCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    /*  myCarIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
            size: Size(context.devicePixelRatio * 1200,
                context.devicePixelRatio * 1250)),
        AppAssetImages.selectedLocationPNGImage); */

    update();
  }

  Future<void> _addTapMarker(LatLng latLng) async {
    // BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      /* final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
        config,
        AppAssetImages.carGPSImage,
      ); */
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(userMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: myCarIcon!));
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
  }

  //----------get nearest driver----------
  Future<void> getNearestDriverList(
      int currentPageNumber, double lat, double lng) async {
    NearestDriverResponse? response = await APIRepo.getNearestDriverList(
        page: currentPageNumber, lat: lat, lng: lng);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetNearestDriverList(response);
  }

  void onSuccessGetNearestDriverList(NearestDriverResponse response) {
    nearestDriverList = response.data.docs;
    update();
  }

  //----------get nearest Car----------
  Future<void> getNearestCarList(
      int currentPageNumber, double lat, double lng) async {
    RentVehicleListResponse? response = await APIRepo.getNearestCarList(
        page: currentPageNumber, lat: lat, lng: lng);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetNearestCarList(response);
  }

  void onSuccessGetNearestCarList(RentVehicleListResponse response) {
    rentCarList = response.data.docs;
    update();
  }

  void currentLocationPass() async {
    final myCurrentLocation = await getCurrentLocation();
    if (myCurrentLocation != null && userDetailsData.country.id.isNotEmpty) {
      getNearestCarList(
          1, myCurrentLocation.latitude!, myCurrentLocation.longitude!);

      if (userDetailsData.country.id.isNotEmpty) {
        getNearestDriverList(
            1, myCurrentLocation.latitude!, myCurrentLocation.longitude!);
      }
    }
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {
    gotoSignInScreen();
  }

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {
    gotoSignInScreen();
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) {
    userDetailsData = response.data;
    update();
  }

  void gotoSignInScreen() async {
    Get.snackbar(
        '', AppLanguageTranslation.sessionExpiredTransKey.toCurrentLanguage);
    await Get.offAllNamed(AppPageNames.logInScreen, arguments: true);
  }

  @override
  void onInit() {
    // getLoggedInUserDetails();
    location = Location();
    getCurrentLocation();

    super.onInit();
    userDetailsData = Helper.getUser();

    _requestPermission();
    createCarsLocationIcon();
    currentLocationPass();

    // Request permission if not granted
  }
}

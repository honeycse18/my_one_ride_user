import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/models/screenParameters/car_rent_screen_parameter.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class AddHireDriverScreenController extends GetxController {
  var location = Location();
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Position? myPosition;
  double passLatitude = 0.0;
  double passLongitude = 0.0;
  bool witOutLogin = false;

  final PagingController<int, NearestDriverList> nearestDriverPagingController =
      PagingController(firstPageKey: 1);

  void getMyCurrentLocation() async {
    myPosition = await Helper.getGPSLocationData();
    if (!witOutLogin) {
      nearestDriverPagingController.refresh();
    }
    update();
  }

  Future<void> getNearestCarList(
      int currentPageNumber, double lat, double lng) async {
    NearestDriverResponse? response = await APIRepo.getNearestDriverList(
        page: currentPageNumber, lat: lat, lng: lng);
    if (response == null) {
      onErrorGetNearestCarList(response);
      return;
    } else if (response.error) {
      onFailureGetNearestCarList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetNearestCarList(response);
  }

  void onErrorGetNearestCarList(NearestDriverResponse? response) {
    nearestDriverPagingController.error = response;
  }

  void onFailureGetNearestCarList(NearestDriverResponse response) {
    nearestDriverPagingController.error = response;
  }

  void onSuccessGetNearestCarList(NearestDriverResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      nearestDriverPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    nearestDriverPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  Future<void> getCurrentLocation() async {
    try {
      log("Getting current location...");

      var _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        log("Location service not enabled. Requesting service...");
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          log("Location service still not enabled. Exiting.");
          return;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        log("Location permission not granted. Requesting permission...");
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          log("Location permission not granted. Exiting.");
          return;
        }
      }

      LocationData _locationData = await location.getLocation();
      latitude.value = _locationData.latitude ?? 0.0;
      longitude.value = _locationData.longitude ?? 0.0;

      log("Location obtained: Latitude ${latitude.value}, Longitude ${longitude.value}");
    } catch (e) {
      log("Error getting location: $e");
    }
  }
  /*   Future<void> _focusLocation(
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
  } */

  void _getScreenParams() {
    dynamic params = Get.arguments;
    if (params is SendLocationParams) {
      passLongitude = params.lng;
      passLatitude = params.lat;
      witOutLogin = params.withoutLogin;
      update();
    }
  }

  @override
  void onInit() async {
    location = Location();
    _getScreenParams();
    // getCurrentLocation();
    getCurrentLocation();
    getMyCurrentLocation();
    if (witOutLogin) {
      nearestDriverPagingController.addPageRequestListener((pageKey) {
        getNearestCarList(
          pageKey,
          passLatitude,
          passLongitude,
        );
      });
    } else {
      nearestDriverPagingController.addPageRequestListener((pageKey) {
        getNearestCarList(
          pageKey,
          myPosition?.latitude ?? latitude.value,
          myPosition?.longitude ?? longitude.value,
        );
      });
    }

    super.onInit();
  }
}

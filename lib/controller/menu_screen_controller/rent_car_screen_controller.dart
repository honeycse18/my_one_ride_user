import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:one_ride_user/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_user/models/screenParameters/car_rent_screen_parameter.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class RentCarScreenController extends GetxController {
  var location = Location();

  final PagingController<int, RentCarListItem> rentCarPagingController =
      PagingController(firstPageKey: 1);
  LatLng myLatLng = const LatLng(0, 0);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Rx<LatLng> userLocation = Rx<LatLng>(LatLng(0.0, 0.0));
  Position? myPosition;
  double passLatitude = 0.0;
  double passLongitude = 0.0;
  bool witOutLogin = false;

  void getMyCurrentLocation() async {
    myPosition = await Helper.getGPSLocationData();
    if (!witOutLogin) {
      rentCarPagingController.refresh();
    }
    update();
  }

  //----------get nearest Car----------
  Future<void> getNearestCarList(
      int currentPageNumber, double lat, double lng) async {
    RentVehicleListResponse? response = await APIRepo.getNearestCarList(
        page: currentPageNumber, lat: lat, lng: lng);
    if (lat == 0 || lng == 0) {
      rentCarPagingController.error = true;
    }
    if (response == null) {
      rentCarPagingController.error = true;
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      rentCarPagingController.error = response.error;
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetNearestCarList(response);
  }

  void onSuccessGetNearestCarList(RentVehicleListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rentCarPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rentCarPagingController.appendPage(response.data.docs, nextPageNumber);
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
  void onInit() {
    // TODO: implement onInit
    _getScreenParams();
    getCurrentLocation();
    getMyCurrentLocation();
    if (witOutLogin) {
      rentCarPagingController.addPageRequestListener((pageKey) {
        getNearestCarList(pageKey, passLatitude, passLongitude);
      });
    } else {
      rentCarPagingController.addPageRequestListener((pageKey) {
        getNearestCarList(pageKey, myPosition?.latitude ?? latitude.value,
            myPosition?.longitude ?? longitude.value);
      });
    }

    super.onInit();
  }
}

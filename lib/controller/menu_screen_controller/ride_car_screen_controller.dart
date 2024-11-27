import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/screenParameters/car_rent_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class RideCarScreenController extends GetxController {
  var location = Location();
  LatLng myLatLng = const LatLng(0, 0);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Rx<LatLng> userLocation = Rx<LatLng>(LatLng(0.0, 0.0));
  Position? myPosition;
  double passLatitude = 0.0;
  double passLongitude = 0.0;
  bool witOutLogin = false;
  List<NearestCarsListRide> rides = [];

  void getMyCurrentLocation() async {
    myPosition = await Helper.getGPSLocationData();
    update();
  }

  Future<void> getNearestRidesList(double lat, double lang) async {
    NearestCarsListResponse? response =
        await APIRepo.getNearestCarsListWithOutLogin(
      lat: lat,
      lng: lang,
    );
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
    update();
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
    getNearestRidesList(passLatitude, passLongitude);
    getCurrentLocation();
    getMyCurrentLocation();

    super.onInit();
  }
}

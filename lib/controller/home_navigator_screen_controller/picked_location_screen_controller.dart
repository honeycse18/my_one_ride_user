import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/models/api_responses/recent_location_response.dart';
import 'package:one_ride_user/models/api_responses/saved_location_list_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/select_car_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PickedLocationScreenController extends GetxController {
  GoogleMapController? googleMapController;
  // bool locateOnMapSelected = false;
  bool mapMarked = false;
  bool isScheduleRide = false;
  List<SavedLocationListSingleLocation> savedLocations = [];
  List<RecentLocationsData> recentLocations = [];
  final String riderMarkerID = 'riderID';
  final String markerID = 'markerID';
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  TextEditingController pickUpLocationTextController = TextEditingController();
  TextEditingController dropLocationTextController = TextEditingController();
  LocationModel? selectedLocation;
  LocationModel? pickUpLocation;
  LocationModel? dropLocation;
  FocusNode pickUpLocationFocusNode = FocusNode();
  FocusNode dropLocationFocusNode = FocusNode();
  bool pickFocusFirst = true;
  bool dropFocusFirst = true;
  Position? _currentPosition;
  String pickUpSearch = '';
  String dropSearch = '';

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
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
      _addRiderMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    // _setAddress(latLng);
    update();
  }

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    String address = await latLongToAddressWithoutController(
        latLng.latitude, latLng.longitude);
    selectedLocation = LocationModel(
        address: address,
        latitude: latLng.latitude,
        longitude: latLng.longitude);

    // panelController.open();
  }

  Future<void> _addRiderMarker(LatLng latLng) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.riderGPSImage);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(riderMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
    mapMarked = true;
    update();
  }

  void getCurrentPosition(BuildContext context) {
    _getCurrentPosition(context);
  }

  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) {
      log('No permission acquired!');
      return;
    }
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      pickUpLocationTextController.text =
          await latLongToAddressWithoutController(
              _currentPosition?.latitude ?? 0,
              _currentPosition?.longitude ?? 0);
      selectedLocation = LocationModel(
          address: pickUpLocationTextController.text,
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      pickUpLocation = selectedLocation;
      update();
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from currentLocation Tap');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Helper.showSnackBar(AppLanguageTranslation
          .locationServiceDisabledTransKey.toCurrentLanguage);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Helper.showSnackBar(AppLanguageTranslation
            .locationServiceDeniedTransKey.toCurrentLanguage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Helper.showSnackBar(AppLanguageTranslation
          .locationServiceParmanentDeniedTransKey.toCurrentLanguage);
      return false;
    }
    return true;
  }

  /* void getLocation(double lat, double long, TextEditingController isPickup) {
    latLongToAddress(lat, long);
  } */

  Future<String> latLongToAddressWithoutController(
      double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    final placemark = placemarks.firstOrNull;
    if (placemark == null) {
      return '';
    }
    String? street = placemark.street;
    String? locality = placemark.locality;
    String? country = placemark.country;
    return '$street, $locality, $country';
  }

  void onLocateOnMapButtonTap() async {
    /* locateOnMapSelected = !locateOnMapSelected;
    if (locateOnMapSelected) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } else {
      googleMapMarkers.clear();
      googleMapPolylines.clear();
      mapMarked = false;
      update();
    } */
    if (pickUpLocationFocusNode.hasFocus) {
      dynamic res = await Get.toNamed(AppPageNames.selectLocation,
          arguments: SelectLocationScreenParameters(
              locationModel:
                  pickUpLocation ?? LocationModel(latitude: 0, longitude: 0),
              showCurrentLocationButton: true,
              screenTitle: AppLanguageTranslation
                  .selectPickupLocationTransKey.toCurrentLanguage));
      if (res is LocationModel) {
        selectedLocation = res;
        pickUpLocation = res;
        pickUpLocationTextController.text = res.address;
        update();
        if (dropLocationTextController.text.isEmpty) {
          dropLocationFocusNode.requestFocus();
        } else {
          Get.toNamed(AppPageNames.selectCarScreen,
              arguments: SelectCarScreenParameter(
                  pickupLocation: pickUpLocation!,
                  dropLocation: dropLocation!,
                  isScheduleRide: isScheduleRide));
        }
      }
    } else if (dropLocationFocusNode.hasFocus) {
      dynamic res = await Get.toNamed(AppPageNames.selectLocation,
          arguments: SelectLocationScreenParameters(
              locationModel:
                  dropLocation ?? LocationModel(latitude: 0, longitude: 0),
              showCurrentLocationButton: false,
              screenTitle: AppLanguageTranslation
                  .selectDropLocationTransKey.toCurrentLanguage));
      if (res is LocationModel) {
        selectedLocation = res;
        dropLocation = res;
        dropLocationTextController.text = res.address;
        update();
        if (pickUpLocationTextController.text.isEmpty) {
          pickUpLocationFocusNode.requestFocus();
        } else {
          Get.toNamed(AppPageNames.selectCarScreen,
              arguments: SelectCarScreenParameter(
                  pickupLocation: pickUpLocation!,
                  dropLocation: dropLocation!,
                  isScheduleRide: isScheduleRide));
        }
      }
    } else {
      APIHelper.onError(
          AppLanguageTranslation.focusFieldTransKey.toCurrentLanguage);
      return;
    }
    update();
  }

  void onFocusChange() {
    if (/* locateOnMapSelected && */
        pickFocusFirst && pickUpLocationFocusNode.hasFocus) {
      hideKeyBoard();
      pickFocusFirst = false;
    } else if (/* locateOnMapSelected && */
        dropFocusFirst && dropLocationFocusNode.hasFocus) {
      hideKeyBoard();
      dropFocusFirst = false;
    } else {
      pickFocusFirst = true;
      dropFocusFirst = true;
    }
  }

  void onConfirmLocationButtonTap() {
    log('Confirm Location Button got tapped!');
    if (pickUpLocationFocusNode.hasFocus) {
      /* latLongToAddress(
          googleMapMarkers.first.position.latitude,
          googleMapMarkers.first.position.longitude,
          pickUpLocationTextController); */
      pickUpLocationTextController.text = selectedLocation?.address ?? '';
      pickUpLocation = selectedLocation;
      update();
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from pickupLocation');
      }
    } else if (dropLocationFocusNode.hasFocus) {
      /* latLongToAddress(
          googleMapMarkers.first.position.latitude,
          googleMapMarkers.first.position.longitude,
          dropLocationTextController); */
      dropLocationTextController.text = selectedLocation?.address ?? '';
      dropLocation = selectedLocation;
      update();
      if (pickUpLocationTextController.text.isEmpty) {
        pickUpLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from dropLocation');
      }
    } else {
      APIHelper.onError(
          AppLanguageTranslation.focusFieldTransKey.toCurrentLanguage);
    }
  }

  Future<void> getSavedLocationList({String? search}) async {
    SavedLocationListResponse? response =
        await APIRepo.getSavedLocationList(search: search);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingSavedLocationList(response);
  }

  onSuccessGettingSavedLocationList(SavedLocationListResponse response) {
    savedLocations = response.data;
    update();
  }

  Future<void> getRecentLocationList({String? search}) async {
    RecentLocationResponse? response =
        await APIRepo.getRecentLocationList(search: search);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingRecentLocationList(response);
  }

  onSuccessGettingRecentLocationList(RecentLocationResponse response) {
    recentLocations = response.data;
    update();
  }

  void onSavedLocationTap(dynamic location) {
    double latitude = 0;
    double longitude = 0;
    String address = '';
    if (location is SavedLocationListSingleLocation) {
      latitude = location.location.lat;
      longitude = location.location.lng;
      address = location.address;
    } else if (location is RecentLocationsData) {
      latitude = location.location.lat;
      longitude = location.location.lng;
      address = location.address;
    }
    if (pickUpLocationFocusNode.hasFocus) {
    } else if (dropLocationFocusNode.hasFocus) {}
    if (pickUpLocationFocusNode.hasFocus) {
      pickUpLocation = LocationModel(
          latitude: latitude, longitude: longitude, address: address);
      pickUpLocationTextController.text = address;
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
      } else {
        Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
      }
    } else if (dropLocationFocusNode.hasFocus) {
      dropLocation = LocationModel(
          latitude: latitude, longitude: longitude, address: address);
      dropLocationTextController.text = address;
      if (pickUpLocationTextController.text.isEmpty) {
        pickUpLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from dropLocation');
      }
    } else {
      APIHelper.onError(
          AppLanguageTranslation.focusFieldTransKey.toCurrentLanguage);
    }
    update();
  }

  void hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is bool) {
      isScheduleRide = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    pickUpLocationFocusNode.requestFocus();
    hideKeyBoard();
    // FocusManager.instance.primaryFocus?.unfocus();
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      pickUpLocationFocusNode.requestFocus();
      FocusManager.instance.primaryFocus?.unfocus(); // Hide the keyboard
    }); */
    pickUpLocationFocusNode.addListener(() {
      if (pickUpLocationFocusNode.hasFocus) {
        log("PickUpLocation one got focused.");
      } else {
        log("PickUpLocation one got unfocused.");
      }
      update();
    });
    dropLocationFocusNode.addListener(() {
      if (dropLocationFocusNode.hasFocus) {
        log("DropLocation one got focused.");
      } else {
        log("DropLocation one got unfocused.");
      }
      update();
    });

    dropLocationTextController.addListener(() {
      dropSearch = dropLocationTextController.text;
      update();
      getSavedLocationList(search: dropSearch);
      getRecentLocationList(search: dropSearch);
    });
    pickUpLocationTextController.addListener(() {
      pickUpSearch = pickUpLocationTextController.text;
      update();
      getSavedLocationList(search: pickUpSearch);
      getRecentLocationList(search: pickUpSearch);
    });
    getSavedLocationList();
    getRecentLocationList();

    super.onInit();
  }

  @override
  void onClose() {
    googleMapMarkers.clear();
    googleMapController?.dispose();
    googleMapPolylines.clear();
    super.onClose();
  }
}

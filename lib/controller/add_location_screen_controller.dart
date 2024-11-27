import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/add_location_save_address_as.dart';
import 'package:one_ride_user/models/screenParameters/saved_location_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class AddLocationScreenController extends GetxController {
  String locationID = '';
  LatLng cameraPosition = const LatLng(22.816904, 89.544045);
  double zoomLevel = 12;
  bool othersClicked = false;
  bool buttonOkay = false;
  final Set<Marker> googleMapMarkers = {};
  late GoogleMapController googleMapController;
  SavedLocationScreenParameter savedLocationScreenParameter =
      SavedLocationScreenParameter(
          locationModel: LocationModel(latitude: 0, longitude: 0),
          addressType: '');
  List<SaveAddressAsTabsItem> saveAsOptions = [
    SaveAddressAsTabsItem(
        name: 'Home', icon: AppAssetImages.homeDarkSVGLogoSolid),
    SaveAddressAsTabsItem(
        name: 'Office', icon: AppAssetImages.officeDarkSVGLogoSolid),
    SaveAddressAsTabsItem(
        name: 'Other', icon: AppAssetImages.mallDarkSVGLogoSolid),
  ];
  SaveAddressAsTabsItem? selectedSaveAsOption;
  TextEditingController addressNameEditingController = TextEditingController();

  void onOptionTap(int index) {
    othersClicked = index == 2;
    buttonOkay = index != 2;
    selectedSaveAsOption = saveAsOptions[index];
    update();
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    _markSelectedLocation();
  }

  void onAddLocationButtonTap() {
    if (locationID.isEmpty) {
      addLocation();
    } else {
      patchLocation();
    }
  }

  Future<void> addLocation() async {
    final Map<String, dynamic> requestBody = getRequestBody();
    RawAPIResponse? response = await APIRepo.addFavoriteLocation(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAddingNewLocation(response);
  }

  onSuccessAddingNewLocation(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> patchLocation() async {
    final Map<String, dynamic> requestBody = getRequestBody();
    RawAPIResponse? response = await APIRepo.updateSavedLocation(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessUpdatingSavedLocation(response);
  }

  onSuccessUpdatingSavedLocation(RawAPIResponse response) {
    Get.back(result: true);
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Map<String, dynamic> getRequestBody() {
    final Map<String, dynamic> location = {
      'lat': savedLocationScreenParameter.locationModel.latitude,
      'lng': savedLocationScreenParameter.locationModel.longitude
    };
    final Map<String, dynamic> requestBody = {
      'label': selectedSaveAsOption?.name ?? 'Other',
      'name': ' ',
      'address': savedLocationScreenParameter.locationModel.address,
      'location': location
    };
    if (locationID.isNotEmpty) {
      requestBody['_id'] = locationID;
    }
    if (selectedSaveAsOption?.name == 'Other') {
      requestBody['name'] = addressNameEditingController.text;
    }
    return requestBody;
  }

  void onLocationTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: savedLocationScreenParameter.locationModel,
            screenTitle:
                locationID.isEmpty ? 'Save Location' : 'Update Location',
            showCurrentLocationButton: true));
    if (result is LocationModel) {
      savedLocationScreenParameter.locationModel = result;
      cameraPosition = LatLng(
          savedLocationScreenParameter.locationModel.latitude,
          savedLocationScreenParameter.locationModel.longitude);
      _markSelectedLocation();
      update();
    }
    buttonOkay = selectedSaveAsOption != null &&
        (selectedSaveAsOption != saveAsOptions[2] ||
            addressNameEditingController.text.isNotEmpty);
    update();
  }

  _markSelectedLocation() async {
    // int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    BitmapDescriptor selectedLocationIcon =
        await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 100)),
            AppAssetImages.selectedLocPNGImage);
    googleMapMarkers.add(Marker(
        markerId: const MarkerId('selectedLocation'),
        position: LatLng(savedLocationScreenParameter.locationModel.latitude,
            savedLocationScreenParameter.locationModel.longitude),
        icon: selectedLocationIcon,
        anchor: const Offset(0.5, 0.565)));
    // anchor: const Offset(0.555, 0.565)));
    update();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(cameraPosition.latitude, cameraPosition.longitude),
            zoom: zoomLevel)));
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SavedLocationScreenParameter) {
      savedLocationScreenParameter = params;
      locationID = savedLocationScreenParameter.id;
      update();
      String option = savedLocationScreenParameter.addressType;
      if (option == 'Home') {
        selectedSaveAsOption = saveAsOptions[0];
      } else if (option == 'Office') {
        selectedSaveAsOption = saveAsOptions[1];
      } else if (option == 'Other') {
        selectedSaveAsOption = saveAsOptions[2];
        addressNameEditingController.text =
            savedLocationScreenParameter.othersText ?? '';
        othersClicked = true;
      }
      update();
      /* log(savedLocationScreenParameter?.locationModel.latitude.toString() ??
          'Latitude Not found!');
      log(savedLocationScreenParameter?.locationModel.longitude.toString() ??
          'Longitude Not found!'); */
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    // _markSelectedLocation();
    addressNameEditingController.addListener(() {
      if (selectedSaveAsOption?.name == 'Other' &&
          addressNameEditingController.text.isNotEmpty) {
        buttonOkay = true;
      } else {
        buttonOkay = false;
      }
      update();
    });
    super.onInit();
  }
}

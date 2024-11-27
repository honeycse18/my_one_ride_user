import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/saved_location_list_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/saved_location_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class SavedLocationsScreenController extends GetxController {
  String test = 'Working';
  List<SavedLocationListSingleLocation> savedLocations = [];

  void onAddLocationButtonTap() async {
    await Get.toNamed(AppPageNames.addLocationScreen);
    getSavedLocationList();
  }

  void onEditLocationButtonTap(SavedLocationListSingleLocation location) async {
    dynamic res = await Get.toNamed(AppPageNames.addLocationScreen,
        arguments: SavedLocationScreenParameter(
            id: location.id,
            addressType: location.label,
            othersText: location.name,
            locationModel: LocationModel(
                latitude: location.location.lat,
                longitude: location.location.lng,
                address: location.address)),
        preventDuplicates: true);
    if (res is bool && true) {
      getSavedLocationList();
    }
  }

  Future<void> getSavedLocationList() async {
    SavedLocationListResponse? response = await APIRepo.getSavedLocationList();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseSavedLocationTransKey.toCurrentLanguage);
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

  void onDeleteButtonTap(String id) {
    deleteSavedLocation(id);
  }

  Future<void> deleteSavedLocation(String id) async {
    RawAPIResponse? response = await APIRepo.deleteSavedLocation(id: id);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessDeletingSavedLocation(response);
  }

  onSuccessDeletingSavedLocation(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    await getSavedLocationList();
    update();
  }

  @override
  void onInit() {
    getSavedLocationList();
    super.onInit();
  }
}

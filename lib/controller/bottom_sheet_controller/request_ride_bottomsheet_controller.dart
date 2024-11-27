import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/all_categories_response.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class RequestRideBottomSheetScreenController extends GetxController {
  RxInt seat = 0.obs;

  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();
  RxDouble rate = 0.0.obs;
  TextEditingController vehicleNumberController = TextEditingController();
  List<AllCategoriesDoc> categories = [];
  AllCategoriesDoc? selectedCategory;
  bool type = false;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  void onRateAddTap() {
    rate.value += 1;
    update();
  }

  void onRateRemoveTap() {
    rate.value -= 1;
    update();
  }

  void onSeatAddTap() {
    seat.value += 1;
    update();
  }

  void onSeatRemoveTap() {
    seat.value -= 1;
    update();
  }

  //------------Hire Me Section--------------------
  Future<void> requestRide() async {
    final Map<String, dynamic> requestBody = {
      '_id': requestDetails.id,
      'seats': seat.value,
      'rate': rate.value,
    };
    if (type) {
      DateTime date = selectedDate.value;
      TimeOfDay time = selectedTime.value;
      DateTime combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      String dateTime = Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
      requestBody['date'] = dateTime;
      requestBody['category'] = selectedCategory?.id ?? '';
      requestBody['vehicle_number'] = vehicleNumberController.text;
    }
    RawAPIResponse? response = await APIRepo.requestRide(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessPostRideRequest(response);
  }

  void _onSuccessPostRideRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.shareRideSuccessDialog(
        messageText: response.msg,
        homeButtonTap: () async {
          Get.offAllNamed(AppPageNames.homeNavigatorScreen);
        });
  }

  Future<void> getCategories() async {
    AllCategoriesResponse? response = await APIRepo.getAllCategories();
    if (response == null) {
      log(AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(AllCategoriesResponse response) {
    categories = response.data.docs;
    selectedCategory = categories.firstOrNull ?? AllCategoriesDoc.empty();
    update();
  }

  void _getScreenParameter() {
    dynamic params = Get.arguments;
    if (params is OfferOverViewBottomsheetScreenParameters) {
      requestDetails = params.requestDetails;
      type = params.type != 'vehicle';
      rate.value = params.requestDetails.rate;
      seat = params.seat.obs;
      update();
      if (type) {
        // Need to change this for Driver App
        getCategories();
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}

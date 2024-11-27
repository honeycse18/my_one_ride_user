import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/all_categories_response.dart';
import 'package:one_ride_user/models/api_responses/post_pulling_request_response.dart';
import 'package:one_ride_user/models/screenParameters/offer_ride_bottomsheet_parameters.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class OfferRideBottomSheetController extends GetxController {
  OfferRideBottomSheetParameters offerRideBottomSheetParameters =
      OfferRideBottomSheetParameters.empty();
  int seatSelected = 0;
  TextEditingController seatPriceController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  List<AllCategoriesDoc> categories = [];
  AllCategoriesDoc? selectedCategory;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
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

  Map<String, dynamic> getRequestBody() {
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
    final Map<String, dynamic> pickLocation = {
      'lat': offerRideBottomSheetParameters.pickUpLocation.latitude,
      'lng': offerRideBottomSheetParameters.pickUpLocation.longitude
    };
    final Map<String, dynamic> from = {
      'address': offerRideBottomSheetParameters.pickUpLocation.address,
      'location': pickLocation
    };
    final Map<String, dynamic> dropLocation = {
      'lat': offerRideBottomSheetParameters.dropLocation.latitude,
      'lng': offerRideBottomSheetParameters.dropLocation.longitude
    };
    final Map<String, dynamic> to = {
      'address': offerRideBottomSheetParameters.dropLocation.address,
      'location': dropLocation
    };
    return {
      'date': dateTime,
      'type': offerRideBottomSheetParameters.isCreateOffer
          ? 'vehicle'
          : 'passenger',
      'from': from,
      'to': to,
      'seats': seatSelected,
      'rate': seatPriceController.text,
    };
  }

  void onSubmitButtonTap() {
    if (seatSelected < 1) {
      AppDialogs.showErrorDialog(
          messageText: 'You must select number of seats to proceed!');
      return;
    }
    final Map<String, dynamic> requestBody = getRequestBody();
    if (offerRideBottomSheetParameters.isCreateOffer) {
      requestBody['category'] = selectedCategory?.id ?? '';
      requestBody['vehicle_number'] = vehicleNumberController.text;
    }
    submitOrder(requestBody);
  }

  Future<void> submitOrder(Map<String, dynamic> requestBody) async {
    PostPullingRequestResponse? response =
        await APIRepo.createNewRequest(requestBody);
    if (response == null) {
      log(AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCreatingPost(response);
  }

  onSuccessCreatingPost(PostPullingRequestResponse response) {
    Get.back();
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is OfferRideBottomSheetParameters) {
      offerRideBottomSheetParameters = params;
      update();
      if (offerRideBottomSheetParameters.isCreateOffer) {
        getCategories();
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

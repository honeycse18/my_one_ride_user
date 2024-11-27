import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/car_rent_details_response.dart';
import 'package:one_ride_user/models/api_responses/post_rent_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class CarRentBottomSheetScreenController extends GetxController {
  Rx<RentCarStatusStatus> messageTypeTab = RentCarStatusStatus.hourly.obs;
  CarRentItem carRentDetails = CarRentItem.empty();
  // RxDouble totalAmount = 0.0.obs;

  void onTabTap(RentCarStatusStatus tab) {
    messageTypeTab.value = tab;
    update();
  }

  void onAddTap() {
    amount.value++;
    update();
  }

  void onRemoveTap() {
    amount.value--;
    update();
  }

  var selectedStartDate = DateTime.now().obs;
  var selectedStartTime = TimeOfDay.now().obs;
  RxInt amount = 1.obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedStartDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedStartTime.value = newTime;
    selectedStartDate.value = DateTime(
        selectedStartDate.value.year,
        selectedStartDate.value.month,
        selectedStartDate.value.day,
        newTime.hour,
        newTime.minute);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is CarRentItem) {
      carRentDetails = argument;
    }
  }

  double get rate {
    return messageTypeTab.value == RentCarStatusStatus.hourly
        ? carRentDetails.prices.hourly.price
        : messageTypeTab.value == RentCarStatusStatus.weekly
            ? carRentDetails.prices.weekly.price
            : carRentDetails.prices.monthly.price;
  }

  double get totalAmount {
    return messageTypeTab.value == RentCarStatusStatus.hourly
        ? carRentDetails.prices.hourly.price * amount.value
        : messageTypeTab.value == RentCarStatusStatus.weekly
            ? carRentDetails.prices.weekly.price * amount.value
            : carRentDetails.prices.monthly.price * amount.value;
  }

  double get hourlyCalTap {
    return amount.value * carRentDetails.prices.hourly.price;
  }

  double get weeklyCalTap {
    return amount.value * carRentDetails.prices.weekly.price;
  }

  double get monthlyCalTap {
    return amount.value * carRentDetails.prices.monthly.price;
  }

  Future<void> postRentRequest() async {
    final Map<String, dynamic> requestBody = {
      'rent': carRentDetails.id,
      'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedStartDate.value),
      'type': messageTypeTab.value.stringValue,
      'rate': rate,
      'quantity': amount.value,
      'total': totalAmount,
    };

    PostRentResponse? response = await APIRepo.postRentRequest(requestBody);

    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessPaymentStatus(response);
  }

  _onSucessPaymentStatus(PostRentResponse response) {
    Get.toNamed(AppPageNames.carRentSummaryScreen, arguments: response.data.id);
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

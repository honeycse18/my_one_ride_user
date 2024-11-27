import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class HireDriverBottomSheetScreenController extends GetxController {
  TextEditingController pickUpLocationTextController = TextEditingController();
  TextEditingController dropLocationTextController = TextEditingController();
  TextEditingController hourlyAmountTextController = TextEditingController();
  TextEditingController fixedAmountTextController = TextEditingController();
  Rx<HireDriverStatus> hireDriverStatus = HireDriverStatus.hourly.obs;
  RxDouble rate = 50.0.obs;

  void onAddTap() {
    rate.value++;
    update();
  }

  void onRemoveTap() {
    rate.value--;
    update();
  }

  FocusNode pickUpLocationFocusNode = FocusNode();
  LocationModel? selectedPickUpLocation;
  LocationModel? selectedDropLocation;

  void changeHireDriverStatusTab(HireDriverStatus tab) {
    hireDriverStatus.value = tab;
    update();
  }

  var selectedStartDate = DateTime.now().obs;
  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndDate = DateTime.now().obs;
  var selectedEndTime = TimeOfDay.now().obs;
  void updateSelectedStartDate(DateTime newDate) {
    selectedStartDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedStartTime.value = newTime;
  }

  void updateSelectedEndDate(DateTime endDate) {
    selectedEndDate.value = endDate;
  }

  void updateSelectedEndTime(TimeOfDay endTime) {
    selectedEndTime.value = endTime;
  }

  NearestDriverList hireDriver = NearestDriverList.empty();
  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is NearestDriverList) {
      hireDriver = argument;
    }
  }

  //------------Hire Me Section--------------------
  Future<void> toggleRentChanges() async {
    final Map<String, dynamic> requestBody = {
      'driver': hireDriver.id,
      'pickup': pickUpLocationTextController.text,
      if (dropLocationTextController.text.isNotEmpty)
        'destination': dropLocationTextController.text,
      'start': {
        'date': Helper.ddMMyyyyFormattedDateTime(selectedStartDate.value),
        'time': Helper.hhmm24FormattedDateTime(selectedStartTime.value),
      },
      'end': {
        'date': Helper.ddMMyyyyFormattedDateTime(selectedEndDate.value),
        'time': Helper.hhmm24FormattedDateTime(selectedEndTime.value),
      },
      'amount': hireDriverStatus.value == HireDriverStatus.hourly
          ? rate.value
          : fixedAmountTextController.text,
      'type': hireDriverStatus.value == HireDriverStatus.hourly
          ? 'hourly'
          : 'fixed',
    };
    RawAPIResponse? response = await APIRepo.hireDriver(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessEditingAccountResponse(response);
  }

  void _onSuccessEditingAccountResponse(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

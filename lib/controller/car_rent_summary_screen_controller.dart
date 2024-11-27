import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/post_rent_response.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class CarRentSummaryScreenController extends GetxController {
  /*  int amount = 1;
  double totalAmount = 0;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  CarRentItem carRentDetails = CarRentItem.empty();
  RentCarStatusStatus messageTypeTab = RentCarStatusStatus.hourly;
 */
  final PageController imageController = PageController(keepPage: false);

  PostRentDetailsItem postRentDetails = PostRentDetailsItem.empty();
  String carRentId = '';

  Future<void> getRentDetails() async {
    PostRentResponse? response =
        await APIRepo.getPendingRentDetails(id: carRentId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetRentDetails(response);
  }

  _onSuccessGetRentDetails(PostRentResponse response) {
    postRentDetails = response.data;
    update();
  }

  void paymentScreen() {
    Get.toNamed(AppPageNames.selectPaymentMethodScreen,
        arguments: postRentDetails);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      carRentId = argument;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getRentDetails();
    super.onInit();
  }
}

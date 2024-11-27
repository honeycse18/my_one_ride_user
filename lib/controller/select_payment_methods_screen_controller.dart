import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/car_rent_details_response.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectPaymentMethodScreenController extends GetxController {
  int selectedPaymentMethodIndex = 0;
  String id = '';
  SelectPaymentOptionModel selectedPaymentOption =
      FakeData.paymentOptionList[0];

  int amount = 1;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  CarRentItem carRentDetails = CarRentItem.empty();
  RentCarStatusStatus messageTypeTab = RentCarStatusStatus.hourly;
  final PageController imageController = PageController(keepPage: false);

  double get getRate {
    switch (messageTypeTab) {
      case RentCarStatusStatus.hourly:
        return carRentDetails.prices.hourly.price;
      case RentCarStatusStatus.weekly:
        return carRentDetails.prices.weekly.price;
      case RentCarStatusStatus.monthly:
        return carRentDetails.prices.monthly.price;
      default:
        return 0;
    }
  }

  Future<void> paymentAcceptCarRentRequest() async {
    final Map<String, String> requestBody = {
      '_id': id,
      'method': selectedPaymentOption.value,
    };
    RawAPIResponse? response =
        await APIRepo.paymentAcceptCarRentRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    selectedPaymentOption.value == 'paypal'
        ? _onSucessPaymentStatus(response)
        : _onSucessWalletPaymentStatus(response);
    // _onSuccessAcceptCarRentRequest(response);
  }

  _onSucessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();
    Get.offAllNamed(AppPageNames.homeNavigatorScreen, arguments: 2);
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    Get.offAllNamed(AppPageNames.homeNavigatorScreen, arguments: 2);
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

/*   _onSuccessAcceptCarRentRequest(RawAPIResponse response) {
    AppDialogs.rentPaymentSuccessDialog(
      messageText: response.msg,
      onNoTap: () async {
        Get.offAllNamed(AppPageNames.homeNavigatorScreen, arguments: 2);
      },
      onYesTap: () async {
        Get.offAllNamed(AppPageNames.rentCarListScreen);
      },
    );
  } */

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      id = argument;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

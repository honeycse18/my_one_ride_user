import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class TopupScreenController extends GetxController {
  TextEditingController topUpAmount = TextEditingController();
  String screenTitle = 'Top Up';

  //------------post start method---------------
  Future<void> topUpWallet() async {
    Map<String, dynamic> requestBody = {
      'method': 'paypal',
      'amount': double.parse(topUpAmount.text),
    };
    RawAPIResponse? response = await APIRepo.topUpWallet(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessStartRentStatus(response);
  }

  _onSucessStartRentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    Get.back();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      screenTitle = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

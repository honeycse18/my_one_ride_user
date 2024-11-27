import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods_details.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PaymentMethodPaypalScreenController extends GetxController {
  String id = '';
  TextEditingController payPalNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  WithdrawMethodsDetailsItem? withdrawMethod;

  void postUpdateData() {
    if (id.isEmpty) {
      addInfo();
    } else {
      updateInfo();
    }
  }

  Future<void> updateInfo() async {
    final Map<String, dynamic> requestBody = {
      '_id': id,
      'type': withdrawMethod?.type ?? 'paypal',
      'details': {
        'account_name': payPalNameController.text,
        'account_email': emailAddressController.text
      }
    };
    RawAPIResponse? response = await APIRepo.updateInfo(requestBody);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back(result: true);
  }

  Future<void> addInfo() async {
    final Map<String, dynamic> requestBody = {
      'type': 'paypal',
      'details': {
        'account_name': payPalNameController.text,
        'account_email': emailAddressController.text
      }
    };
    RawAPIResponse? response = await APIRepo.addMethodInfo(requestBody);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back(result: true);
  }

  Future<void> getWithdrawMethodDetails(String id) async {
    final GetWithdrawSavedMethodsDetailsResponse? response =
        await APIRepo.getWithdrawMethodDetails(id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetMethod(response);
  }

  void _onSuccessGetMethod(GetWithdrawSavedMethodsDetailsResponse response) {
    withdrawMethod = response.data;
    payPalNameController.text = withdrawMethod?.details.payAccountName ?? '';
    emailAddressController.text = withdrawMethod?.details.payAccountEmail ?? '';
    update();
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      id = params;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    if (id.isNotEmpty) {
      getWithdrawMethodDetails(id);
    }
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    payPalNameController.dispose();
    emailAddressController.dispose();
    super.onClose();
  }
}

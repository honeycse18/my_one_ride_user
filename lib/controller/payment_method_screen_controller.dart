import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/models/api_responses/car_rent_response.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class PaymentMethodScreenController extends GetxController {
  Rx<PaymentHistoryStatus> paymentTypeTab = PaymentHistoryStatus.card.obs;
  String date = '';

  TextEditingController cardNameTextEditingController = TextEditingController();
  TextEditingController cardPostalCodeTextEditingController =
      TextEditingController();
  TextEditingController cardNumberTextEditingController =
      TextEditingController();
  TextEditingController cardExpireDateTextEditingController =
      TextEditingController();
  TextEditingController cardCvvNumberTextEditingController =
      TextEditingController();
  TextEditingController postalCodeTextEditingController =
      TextEditingController();
  TextEditingController accountHolderNameTextEditingController =
      TextEditingController();
  TextEditingController payAccountHolderNameTextEditingController =
      TextEditingController();
  TextEditingController accountNumberTextEditingController =
      TextEditingController();
  TextEditingController bankNameTextEditingController = TextEditingController();
  TextEditingController branchCodeTextEditingController =
      TextEditingController();
  TextEditingController emailAddressTextEditingController =
      TextEditingController();
  List<WithdrawMethodsItem> withdrawMethods = [];
  WithdrawMethodsItem selectedWithdrawMethod = WithdrawMethodsItem.empty();

  void onPaymentTabTap(PaymentHistoryStatus value) {
    paymentTypeTab.value = value;
    update();
  }

  Future<void> deleteCard(String id) async {
    RawAPIResponse? response = await APIRepo.deleteCard(id);
    if (response == null) {
      APIHelper.onError('Data Do Not save Properly');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    getWithdrawMethod();
  }

  Future<void> getWithdrawMethod() async {
    final GetWithdrawSavedMethodsResponse? response =
        await APIRepo.getWithdrawMethod();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetMethods(response);
  }

  void _onSuccessGetMethods(GetWithdrawSavedMethodsResponse response) {
    withdrawMethods = response.data;

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getWithdrawMethod();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

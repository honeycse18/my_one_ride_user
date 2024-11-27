import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class WithdrawDialogWidgetScreenController extends GetxController {
  TextEditingController amountController = TextEditingController();
  RxBool isElementsLoading = false.obs;
  List<WithdrawMethodsItem> withdrawMethod = [];
  WithdrawMethodsItem? lastSelectedMethod;
  WithdrawMethodsItem? selectedSavedWithdrawMethod;
  final GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();

/*   void onSelectMethodChange(WithdrawMethodsItem? coupon) {
    if (coupon == null) {
      return;
    }
    final WithdrawMethodsItem? foundExistingCoupon = selectedWithdrawMethod
        .firstWhereOrNull((element) => element.id == coupon.id);
    if (foundExistingCoupon != null) {
      // selectedCoupons.remove(foundExistingCoupon);
    } else {
      selectedWithdrawMethod.add(coupon);
    }
    update();
  } */
  void onMethodChanged(WithdrawMethodsItem? value) {
    selectedSavedWithdrawMethod = value!;
    update();
  }

  void onAddNewMethodButtonTap() async {
    await Get.toNamed(AppPageNames.paymentMethodScreen);
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
    log((response.toJson().toString()));
    _onSuccessGetCoupons(response);
  }

  void _onSuccessGetCoupons(GetWithdrawSavedMethodsResponse response) {
    withdrawMethod = response.data;
    update();
  }

  void onContinueButtonTap() {
    if (withdrawKey.currentState?.validate() ?? false) {
      requestWithdraw();
    }
  }

  Future<void> requestWithdraw() async {
    final Map<String, dynamic> requestBody = {
      'amount': double.tryParse(amountController.text) ?? 0,
      'withdraw_method': selectedSavedWithdrawMethod?.id,
    };
    RawAPIResponse? response = await APIRepo.withdrawRequest(requestBody);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseCallingPendingTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getWithdrawMethod();
    super.onInit();
  }
}

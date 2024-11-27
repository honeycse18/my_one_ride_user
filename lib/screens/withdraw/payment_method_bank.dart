import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:one_ride_user/controller/payment_method_bank_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class PaymentMethodBankScreen extends StatelessWidget {
  const PaymentMethodBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodBankScreenController>(
      global: false,
      init: PaymentMethodBankScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, titleWidget: const Text('Bank')),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.nameController,
                  labelText: "Account Holder Name",
                  hintText: "Type account holder name",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.accountNumberController,
                  labelText: "Account Number",
                  hintText: "Type account number",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.bankNameController,
                  labelText: "Bank Name",
                  hintText: "Type bank name",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.branchCodeController,
                  labelText: "Branch Code",
                  hintText: "Type branch code",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ScaffoldBodyWidget(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStretchedButtonWidget(
              onTap: controller.postUpdateData,
              child: const Text('Save'),
            ),
            AppGaps.hGap20,
          ],
        )),
      ),
    );
  }
}

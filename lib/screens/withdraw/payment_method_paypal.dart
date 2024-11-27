import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:one_ride_user/controller/payment_method_paypal_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class PaymentMethodPaypalScreen extends StatelessWidget {
  const PaymentMethodPaypalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodPaypalScreenController>(
      global: false,
      init: PaymentMethodPaypalScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, titleWidget: const Text('Paypal')),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.payPalNameController,
                  labelText: "Account Holder Name",
                  hintText: "Type account holder name",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.emailAddressController,
                  labelText: "Email Address",
                  hintText: "Type email address",
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

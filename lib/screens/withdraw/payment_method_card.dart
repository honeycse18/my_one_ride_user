import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/payment_method_card_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class PaymentMethodCardScreen extends StatelessWidget {
  const PaymentMethodCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodCardScreenController>(
      global: false,
      init: PaymentMethodCardScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, titleWidget: const Text('Card')),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller.cardNameController,
                  labelText: "Card Name",
                  hintText: "Type card name",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.cardNumberController,
                  labelText: "Card Number",
                  hintText: "Type card number",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  labelText: 'Card Expiration Date',
                  hintText: 'Enter Expire Date',
                  isReadOnly: true,
                  controller: TextEditingController(
                      text: DateFormat('yyyy-MM-dd')
                          .format(controller.selectedExpireDate.value)),
                  prefixIcon:
                      const SvgPictureAssetWidget(AppAssetImages.calendar),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 100),
                    );
                    if (pickedDate != null) {
                      controller.updateSelectedExpireDate(pickedDate);
                    }

                    controller.update();
                  },
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.cardCvvNumberController,
                  labelText: "CVV Number",
                  hintText: "Type cvv number",
                ),
                AppGaps.hGap20,
                CustomTextFormField(
                  controller: controller.postalCodeController,
                  labelText: "Postal Code",
                  hintText: "Type postal code",
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

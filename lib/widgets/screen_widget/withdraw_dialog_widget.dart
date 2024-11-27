import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/withdraw_dialouge_screen_dialouge_controller.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class WithdrawDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  // final String buttonText;

  WithdrawDialogWidget({
    this.title = '',
    this.description = '',
    // required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawDialogWidgetScreenController>(
      global: false,
        init: WithdrawDialogWidgetScreenController(),
        builder: (controller) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.withdrawKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              validator: Helper.withdrawValidator,
                              controller: controller.amountController,
                              labelText: "Enter Amount",
                              hintText: AppLanguageTranslation
                                  .enterYourAmountTransKey.toCurrentLanguage,
                            ),
                            AppGaps.hGap16,
                            /*  MultiItemedDropdownButtonWidget<WithdrawMethodsItem>(
                              labelText: AppLanguageTranslation
                                  .withdrawMethodTransKey.toCurrentLanguage,
                              textButton: AppLanguageTranslation
                                  .addMethodTransKey.toCurrentLanguage,
                              hintText: 'Choose Method',
                              onAddButtonTap: controller.onAddNewMethodButtonTap,
                              isLoading: controller.isElementsLoading.value,
                              items: controller.withdrawMethod,
                              value: controller.lastSelectedMethod,
                              selectedItems: controller.selectedWithdrawMethod,
                              getItemText: (item) => item.type.toUpperCase(),
                              isEqual: (fromItem, toItem) {
                                return fromItem.id == toItem.id;
                              },
                              onItemDeleteButtonTap:
                                  controller.onCouponDeleteChange,
                              onChanged: controller.onSelectMethodChange,
                            ), */

                            Obx(() => DropdownButtonFormFieldWidget<
                                    WithdrawMethodsItem>(
                                  labelText: 'Select withdraw method',
                                  hintText: 'Select withdraw method',
                                  items: controller.withdrawMethod,
                                  isLoading: controller.isElementsLoading.value,
                                  value: controller.selectedSavedWithdrawMethod,
                                  getItemText: (item) => item.type,
                                  onChanged: controller.onMethodChanged,
                                )),
                            AppGaps.hGap16,
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomStretchedTextButtonWidget(
                                  buttonText: AppLanguageTranslation
                                      .withdrawTransKey.toCurrentLanguage,
                                  // backgroundColor: AppColors.alertColor,
                                  onTap: controller.onContinueButtonTap,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

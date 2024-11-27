import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/bottom_sheet_controller/select_payment_method_bottomsheet_controller.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/select_payment_method_widget.dart';

class SelectPaymentMethodBottomsheet extends StatelessWidget {
  const SelectPaymentMethodBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPaymentMethodBottomsheetController>(
        global: false,
        init: SelectPaymentMethodBottomsheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: Center(
                    child: CustomIconButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        hasShadow: true,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: AppColors.darkColor,
                          height: 18,
                          width: 18,
                        )),
                  ),
                  title: Text(AppLanguageTranslation
                      .paymentMethodTransKey.toCurrentLanguage),
                ),
                AppGaps.hGap27,
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.paymentOptionList.length,
                      itemBuilder: (context, index) {
                        final paymentOption = FakeData.paymentOptionList[index];
                        return SelectPaymentMethodWidget(
                          paymentOptionImage: paymentOption.paymentImage,
                          cancelReason: paymentOption,
                          selectedCancelReason: controller.paymentOptionList,
                          paymentOption: paymentOption.viewAbleName,
                          hasShadow: controller.selectedReasonIndex == index,
                          onTap: () {
                            controller.selectedReasonIndex = index;
                            controller.paymentOptionList = paymentOption;
                            controller.update();
                          },
                          radioOnChange: (Value) {
                            controller.selectedReasonIndex = index;
                            controller.paymentOptionList = paymentOption;
                            controller.update();
                          },
                          index: index,
                          selectedPaymentOptionIndex:
                              controller.selectedReasonIndex,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                  ],
                )),
                CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .selectOptionTransKey.toCurrentLanguage,
                  onTap: controller.onSubmitButtonTap,
                )
              ]),
            ));
  }
}

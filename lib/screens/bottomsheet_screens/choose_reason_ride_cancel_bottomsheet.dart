import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/bottom_sheet_controller/choose_reason_cancel_ride_controller.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/cancel_reason_screen_widgets.dart';

class ChooseReasonCancelRideBottomSheet extends StatelessWidget {
  const ChooseReasonCancelRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelReasonRideBottomSheetController>(
        global: false,
        init: CancelReasonRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.8,
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
                      .chooseReasonTransKey.toCurrentLanguage),
                ),
                AppGaps.hGap27,
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.cancelRideReason.length,
                      itemBuilder: (context, index) {
                        final cancelReason = FakeData.cancelRideReason[index];
                        return CancelReasonOptionListTileWidget(
                          cancelReason: cancelReason,
                          selectedCancelReason: controller.selectedCancelReason,
                          reasonName: cancelReason.reasonName,
                          hasShadow: controller.selectedReasonIndex == index,
                          onTap: () {
                            controller.selectedReasonIndex = index;
                            controller.selectedCancelReason = cancelReason;
                            controller.update();
                          },
                          radioOnChange: (Value) {
                            controller.selectedReasonIndex = index;
                            controller.selectedCancelReason = cancelReason;
                            controller.update();
                          },
                          index: index,
                          selectedPaymentOptionIndex:
                              controller.selectedReasonIndex,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    if (controller.selectedCancelReason.reasonName == 'Other')
                      SliverToBoxAdapter(
                        child: CustomTextFormField(
                          controller: controller.otherReasonTextController,
                          hintText: AppLanguageTranslation
                              .writeReasonTransKey.toCurrentLanguage,
                          maxLines: 3,
                        ),
                      ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                  ],
                )),
                CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .submitReasonTransKey.toCurrentLanguage,
                  onTap: controller.onSubmitButtonTap,
                )
              ]),
            ));
  }
}

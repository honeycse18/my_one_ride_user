import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/bottom_sheet_controller/submit_review_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class SubmitReviewBottomSheetScreen extends StatelessWidget {
  const SubmitReviewBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitReviewBottomSheetScreenController>(
        global: false,
        init: SubmitReviewBottomSheetScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.submitReviewFormKey,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 2,
                          color: Colors.grey,
                        ),
                        AppGaps.hGap27,
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: const Center(
                                    child: SvgPictureAssetWidget(
                                  AppAssetImages.arrowLeftSVGLogoLine,
                                  color: AppColors.darkColor,
                                )),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              AppLanguageTranslation
                                  .submitReviewTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleBoldTextStyle,
                            ),
                            AppGaps.wGap30,
                            const Spacer(),
                          ],
                        ),
                        AppGaps.hGap20,
                        Obx(
                          () => RatingBar.builder(
                            initialRating: controller.rating.value,
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) =>
                                const SvgPictureAssetWidget(
                              AppAssetImages.starSVGLogoSolid,
                              color: AppColors.primaryColor,
                            ),
                            onRatingUpdate: controller.setRating,
                          ),
                        ),
                        AppGaps.hGap10,
                        Obx(
                          () => Text(
                            controller.rating.value < 1
                                ? AppLanguageTranslation
                                    .weakTransKey.toCurrentLanguage
                                : controller.rating.value < 2
                                    ? AppLanguageTranslation
                                        .emergingTransKey.toCurrentLanguage
                                    : controller.rating.value < 3
                                        ? AppLanguageTranslation
                                            .goodTransKey.toCurrentLanguage
                                        : controller.rating.value < 4
                                            ? AppLanguageTranslation
                                                .strongTransKey
                                                .toCurrentLanguage
                                            : controller.rating.value < 5
                                                ? AppLanguageTranslation
                                                    .excellentTransKey
                                                    .toCurrentLanguage
                                                : AppLanguageTranslation
                                                    .bestTransKey
                                                    .toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle,
                          ),
                        ),
                        AppGaps.hGap10,
                        Obx(
                          () => Text(
                            '${AppLanguageTranslation.yourRatedTransKey.toCurrentLanguage}: ${controller.rating.value} star',
                            style: AppTextStyles.bodyLargeMediumTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ),
                        AppGaps.hGap30,
                        CustomTextFormField(
                          validator: Helper.textFormValidator,
                          controller: controller.commentTextEditingController,
                          labelText: AppLanguageTranslation
                              .writeSomethingTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .writeSomeTransKey.toCurrentLanguage,
                          maxLines: 5,
                        ),
                        AppGaps.hGap30,
                        CustomStretchedButtonWidget(
                          onTap: controller.submitRentReview,
                          child: Text(AppLanguageTranslation
                              .submitReviewTransKey.toCurrentLanguage),
                        ),
                        AppGaps.hGap20,
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

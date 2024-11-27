import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/add_card_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardSCreenController>(
        global: false,
        init: AddCardSCreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .creditCardTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.hGap20,
                  CustomTextFormField(
                    labelText: AppLanguageTranslation
                        .nameOnCardCardTransKey.toCurrentLanguage,
                    hintText: AppLanguageTranslation
                        .cardNameTransKey.toCurrentLanguage,
                    prefixIcon: const SvgPictureAssetWidget(
                        AppAssetImages.cardNameSVGLogoLine),
                  ),
                  AppGaps.hGap24,
                  Obx(() => CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .cardNumberTransKey.toCurrentLanguage,
                        hintText: '***************',
                        isPasswordTextField: true,
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.cardNumberSVGLogoLine),
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            color: Colors.transparent,
                            onPressed: controller.onPasswordSuffixEyeButtonTap,
                            icon: SvgPictureAssetWidget(
                                controller.toggleHidePassword.value
                                    ? AppAssetImages.hideSVGLogoLine
                                    : AppAssetImages.showSVGLogoLine,
                                color: controller.toggleHidePassword.value
                                    ? AppColors.bodyTextColor
                                    : AppColors.primaryColor)),
                      )),
                  AppGaps.hGap24,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .expirationTransKey.toCurrentLanguage,
                          hintText: '02/02/21',
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.calenderSVGLogoLine),
                        ),
                      ),
                      AppGaps.wGap16,
                      Expanded(
                        child: CustomTextFormField(
                          labelText: AppLanguageTranslation
                              .cvvTransKey.toCurrentLanguage,
                          hintText: '3 6 9 ',
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.editSVGLogoLine),
                        ),
                      ),
                    ],
                  ),
                  AppGaps.hGap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguageTranslation
                            .savedCardTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle,
                      ),
                      FlutterSwitch(
                        value: controller.toggleSavedCard.value,
                        width: 35,
                        height: 20,
                        toggleSize: 12,
                        activeColor: AppColors.primaryColor,
                        onToggle: (value) {
                          controller.toggleSavedCard.value = value;
                          controller.update();
                        },
                      ),
                    ],
                  )
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    child: Text(AppLanguageTranslation
                        .addCardTransKey.toCurrentLanguage),
                    onTap: () {},
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/create_new_password_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordScreenController>(
      global: false,
      init: CreateNewPasswordScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppGaps.screenPaddingValue),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.signUpFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top extra spaces
                  // AppGaps.hGap80,
                  /* <---- Verification icon and text ----> */
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppGaps.hGap20,
                        Text(
                            AppLanguageTranslation
                                .createNewPassTransKey.toCurrentLanguage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall),
                        AppGaps.hGap16,
                        Text(
                            AppLanguageTranslation
                                .pleaseConfirmCreateNewPassTransKey
                                .toCurrentLanguage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.bodyTextColor,
                                    overflow: TextOverflow.clip)),
                      ],
                    ),
                  ),
                  AppGaps.hGap36,
                  Obx(() => CustomTextFormField(
                        validator: controller.passwordFormValidator,
                        controller: controller.passwordTextEditingController,
                        isPasswordTextField:
                            controller.toggleHidePassword.value,
                        labelText: AppLanguageTranslation
                            .passwordTransKey.toCurrentLanguage,
                        hintText: '********',
                        prefixIcon:
                            SvgPicture.asset(AppAssetImages.unlockSVGLogoLine),
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            color: Colors.transparent,
                            onPressed: controller.onPasswordSuffixEyeButtonTap,
                            icon: SvgPicture.asset(
                                AppAssetImages.hideSVGLogoLine,
                                color: controller.toggleHidePassword.value
                                    ? AppColors.bodyTextColor
                                    : AppColors.primaryColor)),
                      )),
                  AppGaps.hGap24,
                  Obx(
                    () => CustomTextFormField(
                      validator: controller.confirmPasswordFormValidator,
                      controller:
                          controller.confirmPasswordTextEditingController,
                      isPasswordTextField:
                          controller.toggleHideConfirmPassword.value,
                      labelText: AppLanguageTranslation
                          .confirmPasswordTransKey.toCurrentLanguage,
                      hintText: '********',
                      prefixIcon:
                          SvgPicture.asset(AppAssetImages.unlockSVGLogoLine),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          color: Colors.transparent,
                          onPressed:
                              controller.onConfirmPasswordSuffixEyeButtonTap,
                          icon: SvgPicture.asset(AppAssetImages.hideSVGLogoLine,
                              color: controller.toggleHideConfirmPassword.value
                                  ? AppColors.bodyTextColor
                                  : AppColors.primaryColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
          child: CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.savePassTransKey.toCurrentLanguage,
            onTap: controller
                .onSavePasswordButtonTap /* () {
              Get.toNamed(AppPageNames.passwordChangedScreen);
            } */
            ,
          ),
        ),
      ),
    );
  }
}

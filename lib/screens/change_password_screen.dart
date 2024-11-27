import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/settings_screen_controller/change_password_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ChangePasswordPromptScreen extends StatelessWidget {
  const ChangePasswordPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordCreateController>(
        global: false,
        init: ChangePasswordCreateController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),
              /* <-------- Empty appbar with back button --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(AppLanguageTranslation
                      .changedPasswordTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
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
                        AppGaps.hGap50,
                        TextFormFieldWidget(
                          controller:
                              controller.currentPasswordEditingController,
                          // hasShadow: false,
                          isPasswordTextField: controller.toggleHideOldPassword,
                          labelText: AppLanguageTranslation
                              .currentPassTransKey.toCurrentLanguage,
                          hintText: '********',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.unlockSVGLogoLine),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              color: Colors.transparent,
                              onPressed: () {
                                controller.toggleHideOldPassword =
                                    !controller.toggleHideOldPassword;
                                controller.update();
                              },
                              icon: SvgPictureAssetWidget(
                                  AppAssetImages.hideSVGLogoLine,
                                  color: controller.toggleHideOldPassword
                                      ? AppColors.bodyTextColor
                                      : AppColors.primaryColor)),
                        ),
                        AppGaps.hGap24,
                        /* <---- Create new password text field ----> */
                        TextFormFieldWidget(
                          validator: Helper.passwordFormValidator,
                          controller: controller.newPassword1EditingController,
                          // hasShadow: false,
                          isPasswordTextField: controller.toggleHideNewPassword,
                          labelText: AppLanguageTranslation
                              .newPassTransKey.toCurrentLanguage,
                          hintText: '********',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.unlockSVGLogoLine),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              color: Colors.transparent,
                              onPressed: () {
                                controller.toggleHideNewPassword =
                                    !controller.toggleHideNewPassword;
                                controller.update();
                              },
                              icon: SvgPictureAssetWidget(
                                  AppAssetImages.hideSVGLogoLine,
                                  color: controller.toggleHideNewPassword
                                      ? AppColors.bodyTextColor
                                      : AppColors.primaryColor)),
                        ),
                        AppGaps.hGap24,
                        /* <---- Create confirm password text field ----> */
                        TextFormFieldWidget(
                          validator: controller.confirmPasswordFormValidator,
                          controller: controller.newPassword2EditingController,
                          // hasShadow: false,
                          isPasswordTextField:
                              controller.toggleHideConfirmPassword,
                          labelText: AppLanguageTranslation
                              .confirmPasswordTransKey.toCurrentLanguage,
                          hintText: '********',
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.unlockSVGLogoLine),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              color: Colors.transparent,
                              onPressed: () {
                                controller.toggleHideConfirmPassword =
                                    !controller.toggleHideConfirmPassword;
                                controller.update();
                              },
                              icon: SvgPictureAssetWidget(
                                  AppAssetImages.hideSVGLogoLine,
                                  color: controller.toggleHideConfirmPassword
                                      ? AppColors.bodyTextColor
                                      : AppColors.primaryColor)),
                        ),
                        AppGaps.hGap24,
                        /* <---- Password requirement strong level columns ----> */
                        /* Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* <---- Password strong level widget ----> */
                            PasswordStrongLevelWidget(
                                currentPasswordStrongLevel:
                                    controller.passwordStrongLevel),
                            AppGaps.hGap16,
                            /* <---- Password 1st requirement ----> */
                            /* Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPictureAssetWidget(
                                    AppAssetImages.tickRoundedSVGLogoSolid,
                                    color:
                                        controller.isPasswordOver8Characters
                                            ? AppColors.successColor
                                            : AppColors.darkColor
                                                .withOpacity(0.25)),
                                AppGaps.wGap15,
                                const Text('At least 8 characters',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ), */
                            AppGaps.hGap16,
                            /* <---- Password 2nd requirement ----> */
                            /* Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPictureAssetWidget(
                                    AppAssetImages.tickRoundedSVGLogoSolid,
                                    color: controller
                                            .isPasswordHasAtLeastSingleNumberDigit
                                        ? AppColors.successColor
                                        : AppColors.darkColor
                                            .withOpacity(0.25)),
                                AppGaps.wGap15,
                                const Text('Contain at least 1 number',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ), */
                            AppGaps.hGap24,
                          ],
                        )), */
                        /* <---- Password requirement strong level columns ----> */
                      ],
                    ),
                  ),
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: CustomStretchedTextButtonWidget(
                    buttonText: 'Save password',
                    onTap: controller.onSavePasswordButtonTap),
              ),
            ));
  }
}

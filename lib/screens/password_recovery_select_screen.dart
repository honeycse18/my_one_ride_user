import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:one_ride_user/widgets/screen_widget/password_recovery_select_screen_widgets.dart';

class PasswordRecoverySelectScreen extends StatefulWidget {
  const PasswordRecoverySelectScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRecoverySelectScreen> createState() =>
      _PasswordRecoverySelectScreenState();
}

class _PasswordRecoverySelectScreenState
    extends State<PasswordRecoverySelectScreen> {
  /// Reset password choice
  ResetPasswordSelectedChoice _currentlySelectedChoice =
      ResetPasswordSelectedChoice.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      /* <-------- Empty appbar with back button --------> */
      appBar: CoreWidgets.appBarWidget(
        screenContext: context,
      ),
      /* <-------- Content --------> */
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppGaps.screenPaddingValue),
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
                            .resetPassTransKey.toCurrentLanguage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall),
                    AppGaps.hGap16,
                    Text(
                        AppLanguageTranslation
                            .chooseOptionTransKey.toCurrentLanguage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.bodyTextColor,
                            overflow: TextOverflow.clip)),
                  ],
                ),
              ),
              AppGaps.hGap40,
              /* <---- Email option select ----> */
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectResetPasswordWidget(
                    titleText: AppLanguageTranslation
                        .sendYourMailTransKey.toCurrentLanguage,
                    contentText: AppLanguageTranslation
                        .passwordResetTransKey.toCurrentLanguage,
                    isSelected: _currentlySelectedChoice ==
                        ResetPasswordSelectedChoice.mail,
                    currentSelectedRadioValue: ResetPasswordSelectedChoice.mail,
                    groupRadioValue: _currentlySelectedChoice,
                    localSVGIconName: AppAssetImages.email,
                    onTap: () => setState(() => _currentlySelectedChoice =
                        ResetPasswordSelectedChoice.mail),
                  ),
                  AppGaps.hGap24,
                  SelectResetPasswordWidget(
                    titleText: AppLanguageTranslation
                        .sendPhoneNumberTransKey.toCurrentLanguage,
                    contentText: AppLanguageTranslation
                        .passwordResetLinkTransKey.toCurrentLanguage,
                    currentSelectedRadioValue:
                        ResetPasswordSelectedChoice.phoneNumber,
                    groupRadioValue: _currentlySelectedChoice,
                    isSelected: _currentlySelectedChoice ==
                        ResetPasswordSelectedChoice.phoneNumber,
                    localSVGIconName: AppAssetImages.phoneSVGLogoLine,
                    onTap: () => setState(() => _currentlySelectedChoice =
                        ResetPasswordSelectedChoice.phoneNumber),
                  ),
                ],
              )),
              AppGaps.hGap30,
            ],
          ),
        ),
      ),
      /* <-------- Bottom bar of sign up text --------> */
      bottomNavigationBar: CustomScaffoldBottomBarWidget(
        child: CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.resetPasswordTransKey.toCurrentLanguage,
            onTap: _currentlySelectedChoice == ResetPasswordSelectedChoice.none
                ? null
                : _currentlySelectedChoice == ResetPasswordSelectedChoice.mail
                    ? () {
                        Get.toNamed(AppPageNames.createNewPasswordScreen);
                      }
                    : () {
                        Get.toNamed(AppPageNames.createNewPasswordScreen);
                      }),
      ),
    );
  }
}

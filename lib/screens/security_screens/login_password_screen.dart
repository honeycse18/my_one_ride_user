import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/login_password_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class LogInPasswordScreen extends StatelessWidget {
  const LogInPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInPasswordSCreenController>(
      global: false,
      init: LogInPasswordSCreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          hasBackButton: true,
          titleWidget:
              Text(AppLanguageTranslation.loginTransKey.toCurrentLanguage),
        ),
        body: CustomScaffoldBodyWidget(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.passwordFormKey,
            child: Column(
              children: [
                AppGaps.hGap27,
                Obx(
                  () => CustomTextFormField(
                    validator: Helper.loginPasswordFormValidator,
                    /* Helper.loginPasswordFormValidator */
                    controller: controller.passwordTextEditingController,
                    isPasswordTextField: controller.toggleHidePassword.value,
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
                        icon: SvgPictureAssetWidget(
                            controller.toggleHidePassword.value
                                ? AppAssetImages.hideSVGLogoLine
                                : AppAssetImages.showSVGLogoLine,
                            color: controller.toggleHidePassword.value
                                ? AppColors.bodyTextColor
                                : AppColors.primaryColor)),
                  ),
                ),
                AppGaps.hGap16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /* <---- Forget password? text button ----> */
                    CustomTightTextButtonWidget(
                      onTap: controller.onForgotPasswordButtonTap,
                      child: Text(
                          AppLanguageTranslation
                              .forgotPasswordTransKey.toCurrentLanguage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.alertColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
          child: CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            onTap: controller.onLoginButtonTap,
          ),
        ),
      ),
    );
  }
}

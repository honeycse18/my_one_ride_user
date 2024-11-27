import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:one_ride_user/controller/verification_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationScreenController>(
        global: false,
        init: VerificationScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              extendBodyBehindAppBar: true,
              /* <-------- Empty appbar with back button --------> */
              appBar: CoreWidgets.appBarWidget(screenContext: context),
              /* <-------- Content --------> */
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppGaps.screenPaddingValue),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap80,
                        /* <---- Verification icon and text ----> */
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  AppAssetImages.verificationIllustration,
                                  height: 240),
                              AppGaps.hGap20,
                              HighlightAndDetailTextWidget(
                                  textColor: Colors.black,
                                  subtextColor: Colors.black,
                                  slogan: AppLanguageTranslation
                                      .verificationTransKey.toCurrentLanguage,
                                  subtitle:
                                      '${AppLanguageTranslation.verificationCodeTransKey.toCurrentLanguage} ${controller.isEmail ? 'email' : 'phone'}. Which is ${controller.isEmail ? controller.theData["email"] : controller.theData["phone"]}'),
                            ],
                          ),
                        ),
                        AppGaps.hGap40,
                        /* <---- OTP input field ----> */
                        Pinput(
                          controller: controller.otpInputTextController,
                          length: 4,
                          focusedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle:
                                const TextStyle(color: AppColors.darkColor),
                            decoration: BoxDecoration(
                              // color: AppColors.shadeColor2,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 2),
                              borderRadius: const BorderRadius.all(
                                  AppComponents.defaultBorderRadius),
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(
                              color: Colors.red,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: const BorderRadius.all(
                                  AppComponents.defaultBorderRadius),
                            ),
                          ),
                          submittedPinTheme: const PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: TextStyle(color: Colors.white),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.all(
                                  AppComponents.defaultBorderRadius),
                            ),
                          ),
                          followingPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(
                                color: AppColors.darkColor,
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: AppColors.lineShapeColor),
                              borderRadius: const BorderRadius.all(
                                  AppComponents.defaultBorderRadius),
                            ),
                          ),
                        ),
                        AppGaps.hGap24,
                        Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(AppLanguageTranslation
                                .resendCodeTransKey.toCurrentLanguage),
                            /* <---- Resend otp code remaining text ----> */
                            Text(
                                '${controller.otpTimerDuration.inMinutes.toString().padLeft(2, '0')}'
                                ':${(controller.otpTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                    color: AppColors.primaryColor))
                          ],
                        )),
                        AppGaps.hGap30,
                      ],
                    ),
                  ),
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .verifyOtpTransKey.toCurrentLanguage,
                        onTap: controller.onSendCodeButtonTap),
                    TextButton(
                        onPressed: controller.isDurationOver()
                            ? () {
                                controller.onResendButtonTap();
                              }
                            : /* null */ controller.onResendButtonTap,
                        child: Text(
                            AppLanguageTranslation
                                .resendTransKey.toCurrentLanguage,
                            style:
                                const TextStyle(color: AppColors.darkColor))),
                  ],
                ),
              ),
            ));
  }
}

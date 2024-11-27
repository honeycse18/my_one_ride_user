import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/login_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<LogInScreenController>(
        global: false,
        init: LogInScreenController(),
        builder: (controller) => Scaffold(
          backgroundColor: const Color(0xFFF7F7FB),
          body: ScaffoldBodyWidget(
              hasNoAppbar: true,
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.loginKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGaps.hGap24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                AppLanguageTranslation
                                    .welcomeTransKey.toCurrentLanguage,
                                style: AppTextStyles.titleLargeBoldTextStyle
                                    .copyWith(color: Colors.black)),
                            AppGaps.wGap10,
                            Text('One',
                                style: AppTextStyles.titleLargeBoldTextStyle
                                    .copyWith(color: AppColors.primaryColor)),
                            Text('Ride',
                                style: AppTextStyles.titleLargeBoldTextStyle
                                    .copyWith(color: Colors.black)),
                          ],
                        ),
                        AppGaps.hGap24,
                        Image.asset(
                          'assets/images/loginCar.png',
                          width: 409,
                          height: 248,
                        ),
                        AppGaps.hGap11,
                        Text(
                          '${AppLanguageTranslation.enterYourTransKey.toCurrentLanguage} ${controller.phoneMethod ? AppLanguageTranslation.phoneNumberTransKey.toCurrentLanguage : AppLanguageTranslation.emailAddressTransKey.toCurrentLanguage}' /* ${AppLanguageTranslation.toCreateAccountTransKey.toCurrentLanguage}' */,
                          style: AppTextStyles.bodyLargeTextStyle
                              .copyWith(color: Colors.black),
                        ),
                        AppGaps.hGap15,
                        controller.phoneMethod
                            ? PhoneNumberTextFormFieldWidget(
                                validator: Helper.phoneFormValidator,
                                initialCountryCode:
                                    controller.currentCountryCode,
                                controller:
                                    controller.phoneTextEditingController,
                                hintText: 'Ex: 197464646',
                                onCountryCodeChanged:
                                    controller.onCountryChange,
                              )
                            : CustomTextFormField(
                                validator: Helper.emailFormValidator,
                                controller:
                                    controller.emailTextEditingController,
                                // labelText: 'Email',
                                hintText: 'Ex: abc@example.com',
                                prefixIcon:
                                    SvgPicture.asset(AppAssetImages.email),
                              ),
                        AppGaps.hGap24,
                        CustomStretchedTextButtonWidget(
                          buttonText: AppLanguageTranslation
                              .continueTransKey.toCurrentLanguage,
                          onTap: controller
                              .onContinueButtonTap /* () {
                            Get.toNamed(AppPageNames.registrationScreen);
                          } */
                          ,
                        ),
                        AppGaps.hGap36,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 0.5,
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                              ),
                            ),
                            AppGaps.wGap8,
                            Text(
                              AppLanguageTranslation
                                  .orTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyMediumTextStyle,
                            ),
                            AppGaps.wGap8,
                            Expanded(
                              child: Container(
                                height: 0.5,
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap36,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* <---- Google icon button ----> */
                            controller.phoneMethod
                                ? CustomStretchedOutlinedTextButtonWidget(

                                    // image:
                                    //     Image.asset('assets/icons/gmail.png'),
                                    onTap: controller
                                        .onMethodButtonTap /* () {
                                  // Get.toNamed(AppPageNames.emailLogInScreen);
                                } */
                                    ,
                                    buttonText: AppLanguageTranslation
                                        .continueWithEmailTransKey
                                        .toCurrentLanguage)
                                : CustomStretchedOutlinedTextButtonWidget(
                                    onTap: controller
                                        .onMethodButtonTap /* () {
                                  // Get.toNamed(AppPageNames.emailLogInScreen);
                                } */
                                    ,
                                    buttonText: AppLanguageTranslation
                                        .continueWithPhoneTransKey
                                        .toCurrentLanguage),
                            AppGaps.hGap16,
                            /* CustomStretchedOutlinedTextButtonWidget(
                                image: Image.asset('assets/icons/google.png'),
                                onTap: () {},
                                buttonText: 'Continue With Google'),
                            AppGaps.hGap16,
                            CustomStretchedOutlinedTextButtonWidget(
                                image: Image.asset('assets/icons/facebook.png'),
                                onTap: () {},
                                buttonText: 'Continue With Facebook'),
                            AppGaps.hGap16,
                            CustomStretchedOutlinedTextButtonWidget(
                                image: Image.asset('assets/icons/facebook.png'),
                                onTap: () {
                                  Get.toNamed(AppPageNames.homeNavigatorScreen);
                                },
                                buttonText: 'GO To Home'), */
                          ],
                        ),
                        AppGaps.hGap16,
                      ]),
                ),
              )),
        ),
      );
}

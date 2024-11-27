import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/registration_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<RegistrationScreenController>(
      global: false,
      init: RegistrationScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleWidget: Text(
              AppLanguageTranslation.registrationTransKey.toCurrentLanguage),
        ),
        body: SafeArea(
          child: CustomScaffoldBodyWidget(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.signUpFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppGaps.hGap15,
                    AppGaps.hGap20,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                                isRequired: true,
                                validator: Helper.textFormValidator,
                                controller:
                                    controller.nameTextEditingController,
                                labelText: AppLanguageTranslation
                                    .yourNameTransKey.toCurrentLanguage,
                                hintText: 'Ex : Jhon doe',
                                prefixIcon: SvgPicture.asset(
                                  AppAssetImages.profileSVGLogoLine,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.6),
                                )),
                            AppGaps.hGap16,
                            CustomTextFormField(
                                isRequired: true,
                                validator: Helper.emailFormValidator,
                                controller:
                                    controller.emailTextEditingController,
                                isReadOnly: controller.screenParameter!.isEmail,
                                labelText: AppLanguageTranslation
                                    .emailAddressTransKey.toCurrentLanguage,
                                hintText: 'Ex: abc@example.com',
                                prefixIcon:
                                    SvgPicture.asset(AppAssetImages.email)),
                            AppGaps.hGap16,
                            PhoneNumberTextFormFieldWidget(
                              isRequired: true,
                              validator: Helper.phoneFormValidator,
                              initialCountryCode: controller.currentCountryCode,
                              controller: controller.phoneTextEditingController,
                              isReadOnly: !controller.screenParameter!.isEmail,
                              labelText: AppLanguageTranslation
                                  .phoneNumberTransKey.toCurrentLanguage,
                              hintText: 'Ex: 1921586525',
                              onCountryCodeChanged: controller.onCountryChange,
                            ),
                            AppGaps.hGap16,
                            /* Obx(
                              () => CustomTextFormField(
                                isReadOnly: true,
                                controller: TextEditingController(
                                    text: controller.selectedGender.value),
                                labelText: 'Gender',
                                hintText: 'Gender',
                                prefixIcon:
                                    SvgPicture.asset(AppAssetImages.gender),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.toggleDropdown();
                                  },
                                  child: const Icon(Icons.keyboard_arrow_down),
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller.isDropdownOpen.value,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: const Text('Male'),
                                      onTap: () {
                                        controller.selectGender('Male');
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Female'),
                                      onTap: () {
                                        controller.selectGender('Female');
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Other'),
                                      onTap: () {
                                        controller.selectGender('Other');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ), */
                            AppGaps.hGap16,
                            Obx(() => CustomTextFormField(
                                  isRequired: true,
                                  validator: controller.passwordFormValidator,
                                  controller:
                                      controller.passwordTextEditingController,
                                  isPasswordTextField:
                                      controller.toggleHidePassword.value,
                                  labelText: AppLanguageTranslation
                                      .passwordTransKey.toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHidePassword.value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap16,
                            Obx(() => CustomTextFormField(
                                  isRequired: true,
                                  validator:
                                      controller.confirmPasswordFormValidator,
                                  controller: controller
                                      .confirmPasswordTextEditingController,
                                  isPasswordTextField: controller
                                      .toggleHideConfirmPassword.value,
                                  labelText: AppLanguageTranslation
                                      .confirmPasswordTransKey
                                      .toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.unlockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onConfirmPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHideConfirmPassword
                                                  .value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                                  .value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap5,
                            AppGaps.hGap5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: screenSize.width < 458
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Obx(() => Checkbox(
                                          value: controller
                                              .toggleAgreeTermsConditions.value,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          onChanged: controller
                                              .onToggleAgreeTermsConditions)),
                                    ),
                                  ),
                                ),
                                AppGaps.wGap16,
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.onToggleAgreeTermsConditions(
                                            !controller
                                                .toggleAgreeTermsConditions
                                                .value),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          AppLanguageTranslation
                                              .bySigningTransKey
                                              .toCurrentLanguage,
                                          style:
                                              AppTextStyles.bodyLargeTextStyle,
                                        ),
                                        AppGaps.wGap5,
                                        CustomTightTextButtonWidget(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .termsConditionScreen);
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .termsServiceTransKey
                                                  .toCurrentLanguage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .primaryColor),
                                            )),
                                        AppGaps.wGap5,
                                        Text(AppLanguageTranslation
                                            .andTransKey.toCurrentLanguage),
                                        AppGaps.wGap5,
                                        CustomTightTextButtonWidget(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .privacyPolicyScreen);
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .privacyPolicyTransKey
                                                  .toCurrentLanguage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .primaryColor),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap69,
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
          child: CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.continueTransKey.toCurrentLanguage,
            onTap: controller.onContinueButtonInitialTap
            /* () {
              Get.toNamed(AppPageNames.verificationScreen);
            } */
            ,
          ),
        ),
      ),
    );
  }
}

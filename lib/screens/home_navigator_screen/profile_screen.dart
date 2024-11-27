import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/profile_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountScreenController>(
        global: false,
        init: MyAccountScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.mainBg,
                /* image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill) */
              ),
              child: SafeArea(
                child: Scaffold(
                  // / <-------- Content --------> /
                  body: CustomScaffoldBodyWidget(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top extra spaces
                          AppGaps.hGap10,
                          /* <---- Profile picture, name, phone number, email address
                           ----> */
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // / <---- Profile picture ----> /
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // / <---- Circular profile picture widget ----> /
                                    controller.imageEdit
                                        ? Container(
                                            height: 128,
                                            width: 128,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: Image.memory(
                                                  controller
                                                      .selectedProfileImage,
                                                ).image)),
                                          )
                                        : CachedNetworkImageWidget(
                                            imageURL:
                                                controller.userDetails.image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                              backgroundImage: imageProvider,
                                              radius: 64,
                                            ),
                                          ),
                                    // CircleAvatar(
                                    //   backgroundImage: Image.asset(
                                    //     AppAssetImages.myAccountProfilePicture,
                                    //   ).image,
                                    //   radius: 64,
                                    // ),
                                    // / <---- Small edit circle icon button ----> /
                                    Positioned(
                                        bottom: 7,
                                        right: -3,
                                        child: IconButton(
                                          onPressed: controller
                                              .onEditImageButtonTap /* () async {
                                            // Tapping on it goes to edit my account screen
                                            await Get.toNamed(
                                                AppPageNames.homeScreen);
                                            controller.getUser();
                                            controller.update();
                                          } */
                                          ,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                              minHeight: 34, minWidth: 34),
                                          icon: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: BoxDecoration(),
                                            child: SvgPicture.asset(
                                              AppAssetImages
                                                  .cameraButtonSVGLogoLine,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                AppGaps.hGap18,
                                // / <---- Profile name ----> /
                                Text(
                                  controller.userDetails.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // AppGaps.hGap8,
                                // // / <---- Profile phone number ----> /
                                // Text(controller.userDetails.phone,
                                //     style: const TextStyle(
                                //         color: AppColors.bodyTextColor)),
                                // AppGaps.hGap5,
                                // // / <---- Profile email address ----> /
                                // Text('mail to: ${controller.userDetails.email}',
                                //     style: const TextStyle(
                                //         color: AppColors.bodyTextColor)),
                                AppGaps.hGap32,
                                // / <---- Horizontal dashed line ----> /
                                CustomHorizontalDashedLineWidget(
                                    color:
                                        AppColors.darkColor.withOpacity(0.1)),
                                AppGaps.hGap32,
                                CustomTextFormField(
                                    controller:
                                        controller.nameTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .yourNameTransKey.toCurrentLanguage,
                                    hintText: controller.userDetails.name,
                                    prefixIcon: SvgPicture.asset(
                                      AppAssetImages.profileSVGLogoLine,
                                      color: AppColors.primaryColor,
                                    )),
                                AppGaps.hGap16,
                                CustomTextFormField(
                                    isReadOnly: true,
                                    controller:
                                        controller.emailTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .yourEmailTransKey.toCurrentLanguage,
                                    hintText: controller.userDetails.email,
                                    /* suffixIcon: Text(
                                      controller.emailVerified
                                          ? 'Verified'
                                          : 'Unverified',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: controller.emailVerified
                                              ? AppColors.successColor
                                              : AppColors.alertColor),
                                    ),
                                    suffixIconConstraints:
                                        const BoxConstraints(maxWidth: 70), */
                                    prefixIcon: SvgPicture.asset(
                                      AppAssetImages.email,
                                      color: AppColors.primaryColor,
                                    )),
                                AppGaps.hGap16,
                                PhoneNumberTextFormFieldWidget(
                                  isReadOnly: true,
                                  initialCountryCode:
                                      controller.currentCountryCode,
                                  controller:
                                      controller.phoneTextEditingController,
                                  // isReadOnly: !controller.screenParameter!.isEmail,
                                  /* suffixIcon: Text(
                                    controller.phoneVerified
                                        ? 'Verified'
                                        : 'Unverified',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: controller.phoneVerified
                                            ? AppColors.successColor
                                            : AppColors.alertColor),
                                  ),
                                  suffixIconConstraints:
                                      const BoxConstraints(maxWidth: 70), */
                                  labelText: AppLanguageTranslation
                                      .phoneNumberTransKey.toCurrentLanguage,
                                  hintText: controller.phoneNumber,
                                  onCountryCodeChanged:
                                      controller.onCountryChange,
                                ),
                                AppGaps.hGap16,
                                // DropdownButtonFormFieldWidget(
                                //   hintText: 'Select Gender',
                                //   labelText: 'Gender',
                                //   items: const ['Male', 'Female'],
                                //   getItemText: (p0) => p0,
                                //   onChanged: controller.onGenderChange,
                                // ),
                                AppGaps.hGap16,
                                CustomTextFormField(
                                    controller:
                                        controller.addressTextEditingController,
                                    labelText: AppLanguageTranslation
                                        .addressTransKey.toCurrentLanguage,
                                    isReadOnly: true,
                                    onTap: controller.onAddressTap,
                                    hintText: controller.userDetails.address,
                                    prefixIcon: SvgPicture.asset(
                                      AppAssetImages.pickLocationSVGLogoLine,
                                      color: AppColors.primaryColor,
                                    )),
                                AppGaps.hGap16,

                                /* Center(
                                  child: CountryFlag.fromCountryCode(
                                    'IN',
                                    height: 48,
                                    width: 62,
                                    borderRadius: 8,
                                  ),
                                ), */
                                // / <---- 'Save address' list tile button ----> /

                                DropdownButtonFormFieldWidget(
                                  hintText: AppLanguageTranslation
                                      .yourCountryTransKey.toCurrentLanguage,
                                  labelText: AppLanguageTranslation
                                      .selectCountryTransKey.toCurrentLanguage,
                                  value: controller.selectedCountry,
                                  items: controller.countryList,
                                  isDense: false,
                                  // getItemText: (p0) => p0.name,
                                  getItemChild: controller.countryElementsList,
                                  onChanged: (selectedItem) {
                                    controller.selectedCountry =
                                        selectedItem ?? UserDetailsCountry();
                                    controller.countryEdit =
                                        controller.userDetails.country.id !=
                                            selectedItem?.id;
                                    controller.update();
                                    controller.editable();
                                  },
                                ),

                                // / <---- 'Sign out' list tile button ----> /
                                /* CustomListTileMyAccountWidget(
                                    text: 'Logout',
                                    icon: SvgPicture.asset(
                                      AppAssetImages.email,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      // Get.toNamed(context, AppPageNames.signInScreen);
                                      Helper.logout();
                                    }), */
                                // Bottom extra spaces
                                AppGaps.hGap24,
                                StretchedTextButtonWidget(
                                    onTap: controller.editActive
                                        ? controller.onSaveChangesButtonTap
                                        : null,
                                    buttonText: AppLanguageTranslation
                                        .saveChangesTransKey.toCurrentLanguage),
                                AppGaps.hGap130,
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_screen_widget_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/drawer_address.dart';

class DrawerListWidget extends StatelessWidget {
  const DrawerListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenWidgetController>(
      global: false,
      init: HomeScreenWidgetController(),
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            color: Color.lerp(Colors.white, Colors.black, 0.1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppGaps.screenPaddingValue),
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // controller.refreshUserDetails();
                controller.update();
              },
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  AppGaps.hGap50,
                  AppGaps.hGap2,
                  if (Helper.isUserLoggedIn())
                    RawButtonWidget(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImageWidget(
                                    imageURL: controller.userDetails.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                /* const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: CachedNetworkImageProvider(
                                      'https://koms.korloy.com/resource/lib/ace-admin/assets/avatars/profile-pic.jpg'),
                                ),
                              ), */
                                AppGaps.hGap5,
                                Text(controller.userDetails.name,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle
                                        .copyWith(
                                            color: const Color(0xFF3A416F))),
                                Text(
                                  controller.userDetails.email,
                                  style: AppTextStyles.bodySmallTextStyle
                                      .copyWith(color: const Color(0xFF989BB2)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Get.toNamed(AppPageNames.myProfileScreen);
                      },
                    ),
                  /* AppGaps.hGap36,
                  DrawerMenuSvgWidget(
                      text: 'Your Profile',
                      localAssetIconName: AppAssetImages.userSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        // Get.toNamed(AppPageNames.allStudentScreen);
                      }), */
                  AppGaps.hGap24,
                  if (Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .hireADriverTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.hireDriverSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(AppPageNames.hireDriverScreen);
                        }),
                  if (!Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (!Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .hireADriverTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.hireDriverSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(AppPageNames.addHireDriverScreen);
                        }),
                  /* AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: 'Demo screen',
                      localAssetIconName:
                          AppAssetImages.documentTextSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.demoScreen);
                      }), */
                  AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: AppLanguageTranslation
                          .rentACarTransKey.toCurrentLanguage,
                      localAssetIconName: AppAssetImages.drivingSVGLogoLine,
                      color: AppColors.primaryColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.rentCarScreen);
                        // Get.toNamed(AppPageNames.rentCarListScreen);
                      }),
                  if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .rentCarHistoryTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.historyButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          // Get.toNamed(AppPageNames.rentCarScreen);
                          Get.toNamed(AppPageNames.rentCarListScreen);
                        }),
                  if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .savedLocationTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.locationTickSVGLogoSolid,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(AppPageNames.savedLocationsScreen);
                        }),
                  if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: 'Payment Methods',
                        localAssetIconName:
                            AppAssetImages.saveMethodSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(AppPageNames.paymentMethodScreen);
                        }),

                  /* AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: 'Favorite',
                      localAssetIconName: AppAssetImages.heartShapeSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.favouritListScreen);
                      }), */
                  /* AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: 'Coupon',
                      localAssetIconName:
                          AppAssetImages.discountShapeSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        // Get.toNamed(AppPageNames.allStudentScreen);
                        Get.toNamed(AppPageNames.offerScreen);
                      }), */
                  AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: AppLanguageTranslation
                          .settingsTransKey.toCurrentLanguage,
                      localAssetIconName: AppAssetImages.settingSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () async {
                        // Get.toNamed(AppPageNames.referalScreen);
                        await Get.toNamed(AppPageNames.settingsScreen);
                        controller.update();
                      }),
                  AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: AppLanguageTranslation
                          .aboutUsTransKey.toCurrentLanguage,
                      localAssetIconName:
                          AppAssetImages.informationSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.aboutUsScreen);
                      }),
                  AppGaps.hGap24,
                  DrawerMenuSvgWidget(
                      text: AppLanguageTranslation
                          .hlpSupportTransKey.toCurrentLanguage,
                      localAssetIconName:
                          AppAssetImages.messageQuestionSVGLogoSolid,
                      color: AppColors.primaryColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.helpSupportScreen);
                      }),
                  /*  AppGaps.hGap6,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ),
                  AppGaps.hGap20,
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ),
                  AppGaps.hGap20,
                  DrawerMenuSvgWidget(
                      text: 'Terms & Conditions ',
                      localAssetIconName:
                          AppAssetImages.historyButtonSVGLogoLine,
                      color: AppColors.darkColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.termsConditionScreen);
                      }),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ),
                  AppGaps.hGap20,
                  DrawerMenuSvgWidget(
                      text: 'Privacy policy',
                      localAssetIconName:
                          AppAssetImages.historyButtonSVGLogoLine,
                      color: AppColors.darkColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.privacyPolicyScreen);
                      }),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ),
                  AppGaps.hGap20,
                  DrawerMenuSvgWidget(
                      text: 'My Wallet',
                      localAssetIconName:
                          AppAssetImages.historyButtonSVGLogoLine,
                      color: AppColors.darkColor,
                      onTap: () {
                        Get.toNamed(AppPageNames.myWalletScreen);
                      }),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                      )
                    ],
                  ), */
                  if (!Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (!Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .loginTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.logoutButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: () {
                          Get.offAllNamed(AppPageNames.logInScreen);
                        }),
                  if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                  if (Helper.isUserLoggedIn())
                    DrawerMenuSvgWidget(
                        text: AppLanguageTranslation
                            .logoutTransKey.toCurrentLanguage,
                        localAssetIconName:
                            AppAssetImages.logoutButtonSVGLogoLine,
                        color: AppColors.primaryColor,
                        onTap: controller.onLogOutButtonTap),
                  /* if (Helper.isUserLoggedIn())
                    CustomRawListTileWidget(
                        onTap: controller.onLogOutButtonTap,
                        borderRadiusRadiusValue: const Radius.circular(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppGaps.wGap16,
                            const SvgPictureAssetWidget(
                              AppAssetImages.logoutButtonSVGLogoLine,
                              color: AppColors.primaryColor,
                              height: 24,
                              width: 24,
                            ),
                            AppGaps.wGap16,
                            Expanded(
                              child: Text(
                                  AppLanguageTranslation
                                      .logoutTransKey.toCurrentLanguage,
                                  style: AppTextStyles.bodyMediumTextStyle
                                      .copyWith(color: AppColors.darkColor)),
                            ),
                          ],
                        )), */
                  AppGaps.hGap43,
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

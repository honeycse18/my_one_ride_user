import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/contact_us_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsScreenController>(
        global: false,
        init: ContactUsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              /* <-------- Empty appbar with back button --------> */
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                    AppLanguageTranslation.contactUsTransKey.toCurrentLanguage,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  )),
              // appBar: CoreWidgets.appBarWidget(screenContext: context),
              /* <-------- Content --------> */
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppGaps.screenPaddingValue),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(15),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  child: SvgPicture.asset(
                                    AppAssetImages.gpsSVGLogoLine,
                                    color: AppColors.darkColor,
                                  ),
                                  onTap: () async {
                                    /* final Uri url = Uri.parse(controller
                                        .contactUsDetails.content.map);
                                    try {
                                      if (!await launchUrl(url)) {
                                        AppDialogs.showErrorDialog(
                                            messageText:
                                                'Could not launch $url');
                                      }
                                    } catch (e) {
                                      AppDialogs.showErrorDialog(
                                          messageText:
                                              'Could not launch $url');
                                    } */
                                  },
                                )),
                          ),
                          AppGaps.wGap20,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .addressTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  controller
                                          .contactUsAdminDetails
                                          .content
                                          .contactUs
                                          .officeAddresses
                                          .firstOrNull
                                          ?.address ??
                                      '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap25,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(15),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AppAssetImages.email,
                                  color: AppColors.darkColor,
                                )),
                          ),
                          AppGaps.wGap20,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .emailAddressTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  controller.contactUsAdminDetails.content
                                      .contactUs.email,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap25,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(15),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                  AppAssetImages.callingSVGLogoSolid,
                                  color: AppColors.darkColor),
                            ),
                          ),
                          AppGaps.wGap20,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .phoneTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  controller.contactUsAdminDetails.content
                                      .contactUs.phone,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap30,
                      /* <---- User full name text field ----> */
                      Text(
                        AppLanguageTranslation
                            .getInTouchTransKey.toCurrentLanguage,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap15,
                      TextFormFieldWidget(
                          controller: controller.nameController,
                          validator: controller.nameFormValidator,
                          labelText: AppLanguageTranslation
                              .yourNameTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .yourNameTransKey.toCurrentLanguage,
                          prefixIcon: SvgPicture.asset(
                              AppAssetImages.profileSVGLogoLine,
                              color: AppColors.bodyTextColor)),
                      AppGaps.hGap15,

                      /* <---- User full name text field ----> */
                      TextFormFieldWidget(
                        controller: controller.emailController,
                        // validator: Helper.emailFormValidator,
                        labelText: AppLanguageTranslation
                            .emailAddressTransKey.toCurrentLanguage,
                        hintText: '  contact@gmail.com',
                        prefixIcon: SvgPicture.asset(AppAssetImages.email),
                      ),
                      AppGaps.hGap15,

                      /* <---- User full name text field ----> */
                      TextFormFieldWidget(
                        controller: controller.phoneController,
                        // validator: Helper.phoneFormValidator,
                        labelText: AppLanguageTranslation
                            .phoneNumberTransKey.toCurrentLanguage,
                        hintText: '  +01712000000',
                        prefixIcon:
                            SvgPicture.asset(AppAssetImages.phoneSVGLogoLine),
                      ),
                      AppGaps.hGap15,
                      /* <---- User full name text field ----> */
                      TextFormFieldWidget(
                        controller: controller.subjectController,
                        validator: controller.messageFormValidator,
                        labelText: AppLanguageTranslation
                            .subjectTransKey.toCurrentLanguage,
                        hintText: AppLanguageTranslation
                            .typeSubjectNameTransKey.toCurrentLanguage,
                      ),
                      AppGaps.hGap15,
                      /* <---- Email text field ----> */
                      TextFormFieldWidget(
                        controller: controller.messageController,
                        validator: controller.messageFormValidator,
                        labelText: AppLanguageTranslation
                            .messageTransKey.toCurrentLanguage,
                        maxLines: 5,
                        hintText: AppLanguageTranslation
                            .typeMessageTransKey.toCurrentLanguage,
                      ),
                      AppGaps.hGap15,
                    ],
                  ),
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* <---- Sign up text button ----> */
                    CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .sendMessageTransKey.toCurrentLanguage,
                        onTap: controller.postContactUsSms)
                  ],
                ),
              ),
            ));
  }
}

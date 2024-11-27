import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/help_support_controller.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/settings_screen_widgets.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  /// Toggle value of notification

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpSupportScreenController>(
        global: false,
        init: HelpSupportScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .helpSupportTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .contactUsTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(AppPageNames.contactUsScreen);
                          }),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .privacyPolicyTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(AppPageNames.privacyPolicyScreen);
                          }),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .termTransKey.toCurrentLanguage,
                          /* valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText), */
                          onTap: () {
                            Get.toNamed(AppPageNames.termsConditionScreen);
                          }),
                    ],
                  ),
                ),
              ),
            ));
  }
}

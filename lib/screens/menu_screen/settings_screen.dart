import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/settings_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/settings_screen_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  /// Toggle value of notification

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenController>(
        global: false,
        init: SettingsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .settingsTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap16,
                      Text(
                        AppLanguageTranslation
                            .applicationSettingTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                      AppGaps.hGap24,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .languageTransKey.toCurrentLanguage,
                          valueWidget: SettingsValueTextWidget(
                              text: controller.currentLanguageText),
                          onTap: () async {
                            await Get.toNamed(AppPageNames.languageScreen);
                            controller.update();
                          }),
                      AppGaps.hGap24,

                      /* AppGaps.hGap16,
                      /* <---- 'Notification' List Tile ----> */
                      SettingsListTileWidget(
                          titleText: 'Notification',
                          showRightArrow: false,
                          valueWidget: FlutterSwitch(
                            value: controller.toggleNotification.value,
                            width: 35,
                            height: 20,
                            toggleSize: 12,
                            activeColor: AppColors.primaryColor,
                            onToggle: (value) {
                              controller.toggleNotification.value = value;
                              controller.update();
                            },
                          ),
                          onTap: () {
                            controller.toggleNotification.value =
                                !controller.toggleNotification.value;
                            controller.update();
                          }), */
                      AppGaps.hGap24,
                      Text(
                        AppLanguageTranslation
                            .securityTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiSmallBoldTextStyle,
                      ),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .changedPasswordTransKey.toCurrentLanguage,
                          onTap: () {
                            Get.toNamed(
                                AppPageNames.changePasswordPromptScreen);
                          }),
                      AppGaps.hGap16,
                      SettingsListTileWidget(
                          titleText: AppLanguageTranslation
                              .deleteAccountTransKey.toCurrentLanguage,
                          onTap: () {
                            Get.toNamed(AppPageNames.deleteAccount);
                          }),
                      /* <---- Section space ----> */
                      AppGaps.hGap32,
                    ],
                  ),
                ),
              ),
            ));
  }
}

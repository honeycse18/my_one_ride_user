import 'package:one_ride_user/controller/passward_changed_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangSuccessScreen extends StatelessWidget {
  const PasswordChangSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordChangSuccessScreenController>(
      global: false,
      init: PasswordChangSuccessScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        /* <-------- Empty appbar with back button --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context, hasBackButton: false),
        /* <-------- Content --------> */
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssetImages.passwordChangeSuccessIllustration,
                    cacheHeight: (240 * 1.5).toInt(),
                    cacheWidth: (260 * 1.5).toInt(),
                    height: 240,
                    width: 260),
                AppGaps.hGap56,
                HighlightAndDetailTextWidget(
                    textColor: Colors.black,
                    subtextColor: Color(0xff888AA0),
                    isSpaceShorter: true,
                    slogan: AppLanguageTranslation
                        .passChangedTransKey.toCurrentLanguage,
                    subtitle: AppLanguageTranslation
                        .notWorryTransKey.toCurrentLanguage),
                AppGaps.hGap30,
              ],
            ),
          ),
        ),
        /* <-------- Bottom bar button --------> */
        bottomNavigationBar: CustomScaffoldBottomBarWidget(
          child: CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            onTap: () {
              Get.offAllNamed(AppPageNames.logInScreen);
            },
          ),
        ),
      ),
    );
  }
}

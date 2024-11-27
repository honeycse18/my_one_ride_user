import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/email_login_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailLogInScreenController>(
      global: false,
      init: EmailLogInScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleWidget:
                Text(AppLanguageTranslation.emailTransKey.toCurrentLanguage),
            hasBackButton: true),
        body: CustomScaffoldBodyWidget(
          child: Column(
            children: [
              AppGaps.hGap27,
              CustomTextFormField(
                labelText:
                    AppLanguageTranslation.emailTransKey.toCurrentLanguage,
                hintText:
                    AppLanguageTranslation.enterEmailTransKey.toCurrentLanguage,
                prefixIcon: SvgPicture.asset(AppAssetImages.email),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 37, right: 24, left: 24),
          child: CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.continueTransKey.toCurrentLanguage,
            onTap: () {
              Get.toNamed(AppPageNames.logInPasswordScreen);
            },
          ),
        ),
      ),
    );
  }
}

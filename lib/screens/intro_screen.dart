import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/introscreen_controller.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/intro_screen_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upgrader/upgrader.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      global: false,
      builder: (controller) => UpgradeAlert(
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: const Color(0xFF212121),
              image: DecorationImage(
                  image: Image.asset(AppAssetImages.backgroundFullPng).image,
                  fit: BoxFit.fill)),
          child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false, actions: const [
              /* Row(
                children: [
                  Text(
                    'BN',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  AppGaps.wGap20
                ],
              ) */
            ]),
            /* <-------- Content --------> */
            body: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    /* <---- Intro screens ----> */
                    child: PageView.builder(
                      controller: controller.pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        controller.fakeIntroContent =
                            FakeData.fakeIntroContents[index];
                        controller.update();
                      },
                      itemCount: FakeData.fakeIntroContents.length,
                      itemBuilder: (context, index) {
                        /// Single intro screen data
                        controller.fakeIntroContent =
                            FakeData.fakeIntroContents[index];
                        /* <---- Single Intro screen widget ----> */
                        return IntroContentWidget(
                            screenSize: screenSize,
                            localImageLocation: controller
                                .fakeIntroContent.localSVGImageLocation,
                            slogan: controller.fakeIntroContent.slogan,
                            subtitle: controller.fakeIntroContent.content);
                      },
                    ),
                  ),
                  AppGaps.hGap30,
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!controller
                            .isFirstPage) // Show the icon if page is not 0.
                          GestureDetector(
                            onTap: () {
                              controller.update();
                              controller.gotoPreviousIntroSection(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.textFieldInputColor,
                              size: 18,
                            ),
                          ),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              /* <---- Current page dot indicator widget ----> */
                              child: SmoothPageIndicator(
                                controller: controller.pageController,
                                count: FakeData.fakeIntroContents.length,
                                axisDirection: Axis.horizontal,
                                effect: const ExpandingDotsEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    spacing: 2,
                                    expansionFactor: 3,
                                    activeDotColor:
                                        AppColors.textFieldInputColor,
                                    dotColor: AppColors.bodyTextColor),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.gotoNextIntroSection(context);
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.textFieldInputColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppGaps.hGap10,
                ]),
            /* <-------- Bottom bar --------> */
            bottomNavigationBar: CustomScaffoldBottomBarWidget(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* <---- Next button ----> */
                    Row(
                      children: [
                        Expanded(
                            child: RawButtonWidget(
                          borderRadiusValue: 18,
                          onTap: () {
                            Get.toNamed(AppPageNames.homeNavigatorScreen);
                          },
                          child: Container(
                            height: 62,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18)),
                            child: Center(
                              child: Text(
                                AppLanguageTranslation
                                    .getStartedTransKey.toCurrentLanguage,
                                style: AppTextStyles.semiSmallXBoldTextStyle
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                        ))
                      ],
                    )
                    /* CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .getStartedTransKey.toCurrentLanguage,
                        onTap: () {
                          Get.toNamed(AppPageNames.logInScreen);
                        }), */
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

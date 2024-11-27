import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/models/fakeModel/intro_content_model.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';

class IntroScreenController extends GetxController {
  FakeIntroContent fakeIntroContent = FakeData.fakeIntroContents.first;
  final PageController pageController = PageController(keepPage: false);

  /// Go to next intro section
  void gotoNextIntroSection(BuildContext context) {
    // If intro section ends, goto sign in screen.
    if (isLastPagePage) {
      // Get.toNamed(AppPageNames.logInScreen);
      Get.toNamed(AppPageNames.homeNavigatorScreen);
    }
    // Goto next intro section
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  /// Go to previous intro section
  void gotoPreviousIntroSection(BuildContext context) {
    // Goto next intro section
    pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  bool get isFirstPage {
    try {
      return pageController.page == pageController.initialPage;
    } catch (e) {
      return true;
    }
  }

  bool get isLastPagePage {
    try {
      return pageController.page == FakeData.fakeIntroContents.length - 1;
    } catch (e) {
      return false;
    }
  }
}

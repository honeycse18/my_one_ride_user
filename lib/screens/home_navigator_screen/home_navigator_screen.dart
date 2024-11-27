import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/home_navigator_screen_controller.dart';
import 'package:one_ride_user/screens/home_navigator_screen/home_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/message_list_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/profile_screen.dart';
import 'package:one_ride_user/screens/home_screen_without_login.dart';
import 'package:one_ride_user/screens/my_trip_screen.dart';
import 'package:one_ride_user/screens/my_wallet_screen.dart';
import 'package:one_ride_user/screens/security_screens/login_screen.dart';
import 'package:one_ride_user/screens/unknown_screen.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/home_screen_widget.dart';
import 'package:upgrader/upgrader.dart';

class HomeNavigatorScreen extends StatelessWidget {
  const HomeNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeNavigatorScreenController>(
        global: false,
        init: HomeNavigatorScreenController(),
        builder: (controller) => UpgradeAlert(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: AppColors.mainBg),
                child: WillPopScope(
                  onWillPop: () async {
                    controller.popScope();
                    return await Future.value(true);
                  },
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    // key: controller.homeNavigationKey,
                    extendBody: true,
                    extendBodyBehindAppBar: true,
                    backgroundColor: Colors.transparent,
                    appBar: CoreWidgets.appBarWidget(
                      titleWidget: Text(controller.titleText),
                      screenContext: context,
                      hasBackButton: false,
                      actions: [
                        if (Helper.isUserLoggedIn())
                          Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: IconButtonWidget(
                                  child: const SvgPictureAssetWidget(
                                    AppAssetImages
                                        .notificationButtonSVGLogoLine,
                                    height: 20,
                                    width: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.notificationScreen,
                                        arguments: true);
                                  }),
                            ),
                          ),
                        AppGaps.wGap24
                      ],
                      leading: Center(
                        child: Builder(builder: (context1) {
                          return IconButtonWidget(
                            backgroundColor: Colors.white,
                            onTap: () {
                              Scaffold.of(context1).openDrawer();
                              // controller.homeNavigationKey.currentState?.openDrawer();
                            },
                            child: const SizedBox(
                                height: 24,
                                width: 24,
                                child: SvgPictureAssetWidget(
                                    AppAssetImages.menuButtonSVGLogoLine,
                                    color: AppColors.primaryColor)),
                          );
                        }),
                      ),
                    ),
                    drawer: const Drawer(
                        backgroundColor: Colors.transparent,
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: DrawerListWidget(),
                        )),
                    // body: controller.nestedScreenWidget,
                    body: Helper.isUserLoggedIn()
                        ? IndexedStack(
                            index: controller.currentPageIndex,
                            children: const [
                                MyTripScreen(),
                                MyWalletScreen(),
                                HomeScreen(),
                                MessageListScreen(),
                                MyAccountScreen(),
                              ])
                        : IndexedStack(
                            index: controller.currentPageIndex,
                            children: const [
                                UnknownScreen(),
                                UnknownScreen(),
                                HomeScreenWithoutLogin(),
                                UnknownScreen(),
                                UnknownScreen(),
                              ]),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: AppColors.primaryColor,
                      child: const SvgPictureAssetWidget(
                        AppAssetImages.homeSVGIcon,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.selectHomeNavigatorTabIndex(2);
                      },
                    ),
                    bottomNavigationBar: BottomAppBar(
                      shape: const AutomaticNotchedShape(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        )),
                      ),
                      notchMargin: 7,
                      // shadowColor: Colors.grey.withOpacity(0.2),
                      color: Colors.white,
                      child: SizedBox(
                        height: 65,
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                controller.bottomMenuButton(
                                    AppLanguageTranslation
                                        .myTipTransKey.toCurrentLanguage,
                                    AppAssetImages.routingSVGLogoLine,
                                    0),
                                controller.bottomMenuButton(
                                    AppLanguageTranslation
                                        .walletTransKey.toCurrentLanguage,
                                    AppAssetImages.walletSVGLogoLine,
                                    1),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                controller.bottomMenuButton(
                                    AppLanguageTranslation
                                        .messageTransKey.toCurrentLanguage,
                                    AppAssetImages.messageSVGLogoLine,
                                    3),
                                controller.bottomMenuButton(
                                    AppLanguageTranslation
                                        .profileTransKey.toCurrentLanguage,
                                    AppAssetImages.singlePeopleSVGLogoLine,
                                    4)
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

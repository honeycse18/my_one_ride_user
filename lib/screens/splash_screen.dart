import 'package:one_ride_user/controller/splash_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        global: false,
        init: SplashScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Content --------> */
              // backgroundColor: AppColors.primaryColor,
              body: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset(AppAssetImages.splashScreenAbstract)
                            .image,
                        fit: BoxFit.fitWidth)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* <----- App logo -----> */
                      Image.asset(AppAssetImages.splashLogoAlert,
                          height: 168, width: 115),
                      AppGaps.wGap10,
                      /* <---- App name text ----> */
                      const Text(
                        // Edit this app version code text as it changes
                        'One Ride',

                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

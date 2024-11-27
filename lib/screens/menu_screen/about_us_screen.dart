import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/about_us_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:stroke_text/stroke_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsScreenController>(
        global: false,
        init: AboutUsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.aboutUsTextItem.title)),

              /* <-------- Content --------> */

              body: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 179,
                              child: CachedNetworkImageWidget(
                                imageURL:
                                    'https://github.com/surjo976/Doremon/assets/82593116/27d9872c-154e-4c38-90b2-e1e5f43c02a4',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      AppGaps.hGap24,
                      Text(
                        AppLanguageTranslation
                            .ourHistoryTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSemiboldTextStyle,
                      ),
                      AppGaps.hGap12,
                      Text(
                        controller.aboutUsTextItem.content.ourHistory.heading,
                        style: AppTextStyles.semiSmallXBoldTextStyle,
                      ),
                      AppGaps.hGap10,
                      Text(
                        controller
                            .aboutUsTextItem.content.ourHistory.description1,
                        textAlign: TextAlign.justify,
                      ),
                      AppGaps.hGap10,
                      Text(
                        controller
                            .aboutUsTextItem.content.ourHistory.description2,
                        textAlign: TextAlign.justify,
                      ),
                      AppGaps.hGap24,
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 175,
                                width: 175,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const StrokeText(
                                        text: "6K+",
                                        textStyle: TextStyle(
                                          fontSize: 60,
                                        ),
                                        strokeColor: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                      AppGaps.hGap15,
                                      Text(
                                        AppLanguageTranslation
                                            .appDownloadsTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyBoldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              AppGaps.wGap15,
                              Container(
                                height: 175,
                                width: 175,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const StrokeText(
                                        text: "4K+",
                                        textStyle: TextStyle(
                                            fontSize: 60, color: Colors.black),
                                        strokeColor: Colors.black,
                                        strokeWidth: 4,
                                      ),
                                      AppGaps.hGap15,
                                      Text(
                                        AppLanguageTranslation
                                            .activeRidesTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyBoldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppGaps.hGap16,
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 175,
                                width: 175,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const StrokeText(
                                        text: "30K+",
                                        textStyle: TextStyle(
                                            fontSize: 60, color: Colors.black),
                                        strokeColor: Colors.black,
                                        strokeWidth: 4,
                                      ),
                                      AppGaps.hGap15,
                                      Text(
                                        AppLanguageTranslation.tripSavedTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyBoldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              AppGaps.wGap15,
                              Container(
                                height: 175,
                                width: 175,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const StrokeText(
                                        text: "3K+",
                                        textStyle: TextStyle(
                                          fontSize: 60,
                                        ),
                                        strokeColor: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                      AppGaps.hGap15,
                                      Text(
                                        AppLanguageTranslation
                                            .activeUserTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyBoldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppGaps.hGap30,
                    ],
                  ),
                ),
              ),

              /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}

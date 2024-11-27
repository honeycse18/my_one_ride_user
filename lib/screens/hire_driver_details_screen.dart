import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/hire_driver_screen_controller.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/hire_driver_bottomsheet.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class HireDriverDetailsScreen extends StatelessWidget {
  const HireDriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverDetailsScreenController>(
        global: false,
        init: HireDriverDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.hireDriver.name)),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 256,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppGaps.hGap10,
                              SizedBox(
                                height: 170,
                                width: 170,
                                child: CachedNetworkImageWidget(
                                  imageURL: controller.driverDetailsData.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              AppGaps.hGap16,
                              Text(
                                '${Helper.getCurrencyFormattedWithDecimalAmountText(controller.driverDetailsData.rate)} ${AppLanguageTranslation.hourlyTransKey.toCurrentLanguage}',
                                style: AppTextStyles
                                    .titleSemiSmallSemiboldTextStyle,
                              ),
                              AppGaps.hGap35,
                            ]),
                      ))
                ],
                body: CustomScrollView(
                  slivers: [
                    DecoratedSliver(
                      decoration: const BoxDecoration(
                          // color: AppColors.darkColor,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.darkColor,
                              AppColors.mainBg,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      sliver: SliverList.list(children: [
                        AppGaps.hGap12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                      AppAssetImages.expBadgeSVGLogoLine,
                                    ),
                                  ),
                                ),
                                AppGaps.wGap16,
                                Column(
                                  children: [
                                    Text(
                                      '${controller.driverDetailsData.experience} ${AppLanguageTranslation.yearsTransKey.toCurrentLanguage}',
                                      style: AppTextStyles
                                          .titleSemiSmallBoldTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      AppLanguageTranslation.experiencesTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            AppGaps.wGap16,
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                      AppAssetImages.multPeopleSVGLogoLine,
                                    ),
                                  ),
                                ),
                                AppGaps.wGap16,
                                Column(
                                  children: [
                                    Text(
                                      '${controller.driverDetailsData.hires.total} +',
                                      style: AppTextStyles
                                          .titleSemiSmallBoldTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      AppLanguageTranslation
                                          .tripsTransKey.toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        AppGaps.hGap12,
                        Container(
                          decoration: const BoxDecoration(
                              color: AppColors.mainBg,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: ScaffoldBodyWidget(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppGaps.hGap25,
                                  Text(
                                    AppLanguageTranslation
                                        .aboutUsTransKey.toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle,
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    controller.driverDetailsData.about,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor),
                                    textAlign: TextAlign.justify,
                                  ),
                                  AppGaps.hGap38,
                                  Text(
                                    AppLanguageTranslation
                                        .currentLocationTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle,
                                  ),
                                  AppGaps.hGap8,
                                  Row(
                                    children: [
                                      const SvgPictureAssetWidget(
                                          AppAssetImages.locateSVGLogoLine),
                                      AppGaps.wGap8,
                                      Expanded(
                                          child: Text(controller
                                              .driverDetailsData.address))
                                    ],
                                  ),
                                  /* 
                                  AppGaps.hGap24,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'User Reviews',
                                        style: AppTextStyles
                                            .titleSemiSmallSemiboldTextStyle,
                                      ),
                                      TightSmallTextButtonWidget(
                                        text: 'See All',
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      SingleStarWidget(review: 2),
                                      AppGaps.wGap8,
                                      Text(
                                        '( 4.5 )',
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      )
                                    ],
                                  ), */
                                  AppGaps.hGap24,
                                ]),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.mainBg,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RawButtonWidget(
                        child: Container(
                          height: 62,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(18))),
                          child: const Center(
                            child: SvgPictureAssetWidget(
                                AppAssetImages.chatMeSVGLogoLine),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(AppPageNames.chatScreen,
                              arguments: controller.hireDriver.id);
                        },
                      ),
                      AppGaps.wGap16,
                      Expanded(
                        child: CustomStretchedTextButtonWidget(
                            buttonText: AppLanguageTranslation
                                .hireTimeTransKey.toCurrentLanguage,
                            onTap: () {
                              Get.bottomSheet(HireDriverBottomSheet(),
                                  settings: RouteSettings(
                                      arguments: controller.hireDriver),
                                  isScrollControlled: true,
                                  ignoreSafeArea: false);
                            }),
                      ),
                    ],
                  )),
            ));
  }
}

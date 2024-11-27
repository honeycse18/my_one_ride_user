import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/pulling_request_overview_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PullingRequestOverviewScreen extends StatelessWidget {
  const PullingRequestOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullingRequestOverviewController>(
        init: PullingRequestOverviewController(),
        global: false,
        builder: ((controller) => Scaffold(
              key: controller.bottomSheetFormKey,
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: const Color(0xFFF7F7FB),
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, titleWidget: const Text('')),
              body: Stack(
                children: [
                  Positioned.fill(
                    bottom: MediaQuery.of(context).size.height * 0.32,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition:
                          // AppSingleton.instance.defaultCameraPosition,
                          CameraPosition(
                              target: LatLng(
                                  (controller.cameraPosition.latitude) - 7.7,
                                  controller.cameraPosition.longitude),
                              zoom: controller.zoomLevel),
                      markers: controller.googleMapMarkers,
                      polylines: controller.googleMapPolyLines,
                      onMapCreated: controller.onGoogleMapCreated,
                      // onTap: controller.onGoogleMapTap,
                    ),
                  ),
                  /* Obx(
                      () => controller.rideAccepted.value
                          ?  */
                  SlidingUpPanel(
                      color: Colors.transparent,
                      boxShadow: null,
                      minHeight: 372,
                      maxHeight: 610,
                      panel: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 73.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: AppColors.mainBg,
                              ),
                              child: Column(children: [
                                AppGaps.hGap10,
                                Container(
                                  width: 60,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 3,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Color(0xFFA5A5A5),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: ScaffoldBodyWidget(
                                      child: CustomScrollView(
                                    slivers: [
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap10,
                                      ),
                                      SliverToBoxAdapter(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 156,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    AppLanguageTranslation
                                                        .startDateTimeTransKey
                                                        .toCurrentLanguage,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeTextStyle
                                                        .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor,
                                                    )),
                                                Text(
                                                    Helper
                                                        .ddMMMyyyyhhmmaFormattedDateTime(
                                                            controller
                                                                .requestDetails
                                                                .date),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeMediumTextStyle),
                                              ],
                                            ),
                                            AppGaps.hGap12,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SvgPictureAssetWidget(
                                                  AppAssetImages
                                                      .pickLocationSVGLogoLine,
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                AppGaps.wGap4,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLanguageTranslation
                                                            .pickUpTransKey
                                                            .toCurrentLanguage,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodySmallTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                      AppGaps.hGap4,
                                                      Text(
                                                        controller
                                                            .requestDetails
                                                            .from
                                                            .address,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeMediumTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AppGaps.hGap12,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SvgPictureAssetWidget(
                                                  AppAssetImages
                                                      .solidLocationSVGLogoLine,
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                AppGaps.wGap4,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLanguageTranslation
                                                            .dropLocTransKey
                                                            .toCurrentLanguage,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodySmallTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                      AppGaps.hGap4,
                                                      Text(
                                                        controller
                                                            .requestDetails
                                                            .to
                                                            .address,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeMediumTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap24,
                                      ),
                                      SliverToBoxAdapter(
                                        child: Text(
                                          controller.requestDetails.type ==
                                                  'vehicle'
                                              ? AppLanguageTranslation
                                                  .driverTransKey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .passengerTransKey
                                                  .toCurrentLanguage,
                                          style: AppTextStyles
                                              .notificationDateSection,
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap12,
                                      ),
                                      SliverToBoxAdapter(
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          height: 80,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))),
                                          child: Row(children: [
                                            SizedBox(
                                              height: 45,
                                              width: 45,
                                              child: CachedNetworkImageWidget(
                                                imageURL: controller
                                                    .requestDetails.user.image,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                            ),
                                            AppGaps.wGap10,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.requestDetails
                                                        .user.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                  AppGaps.hGap5,
                                                  const Row(
                                                    children: [
                                                      SingleStarWidget(
                                                          review: 4.9),
                                                      AppGaps.wGap4,
                                                      Text(
                                                        '(831 reviews)',
                                                        style: AppTextStyles
                                                            .smallestMediumTextStyle,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      Helper
                                                          .getCurrencyFormattedWithDecimalAmountText(
                                                              controller
                                                                  .requestDetails
                                                                  .rate
                                                                  .toDouble()),
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle,
                                                    ),
                                                    AppGaps.wGap4,
                                                    Text(
                                                      AppLanguageTranslation
                                                          .perSeatTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .bodyTextColor),
                                                    )
                                                  ],
                                                ),
                                                AppGaps.hGap4,
                                                Row(
                                                  children: [
                                                    const SvgPictureAssetWidget(
                                                        AppAssetImages.seat),
                                                    AppGaps.wGap5,
                                                    Text(
                                                      '${controller.requestDetails.available}',
                                                      style: AppTextStyles
                                                          .bodySmallSemiboldTextStyle,
                                                    ),
                                                    AppGaps.wGap5,
                                                    Text(
                                                      controller.requestDetails
                                                                  .type ==
                                                              'vehicle'
                                                          ? AppLanguageTranslation
                                                              .seatAvailableTransKey
                                                              .toCurrentLanguage
                                                          : AppLanguageTranslation
                                                              .seatNeeTransKey
                                                              .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySmallSemiboldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .bodyTextColor),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ]),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap16,
                                      ),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          children: [
                                            /* RawButtonWidget(
                                              child: Container(
                                                height: 44,
                                                width: 44,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: const Center(
                                                  child: SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .callingSVGLogoSolid),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                            AppGaps.wGap12, */
                                            Expanded(
                                                child:
                                                    CustomMessageTextFormField(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPageNames.chatScreen,
                                                    arguments: controller
                                                        .requestDetails
                                                        .user
                                                        .id);
                                              },
                                              isReadOnly: true,
                                              suffixIcon:
                                                  const SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .sendSVGLogoLine),
                                              boxHeight: 44,
                                              hintText: AppLanguageTranslation
                                                  .messageYourDriverTransKey
                                                  .toCurrentLanguage,
                                            ))
                                          ],
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap16,
                                      ),
                                      if (controller.requestDetails.type ==
                                          'vehicle')
                                        SliverToBoxAdapter(
                                          child: Text(
                                            AppLanguageTranslation
                                                .coPassengerTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                        ),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap8,
                                      ),
                                      if (controller.requestDetails.type ==
                                          'vehicle')
                                        controller.requestDetails.requests
                                                .isNotEmpty
                                            ? SliverGrid(
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                  (BuildContext context,
                                                      int index) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child:
                                                                CachedNetworkImageWidget(
                                                              imageURL: controller
                                                                  .requestDetails
                                                                  .user
                                                                  .image,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                          ),
                                                          AppGaps.wGap8,
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .requestDetails
                                                                      .user
                                                                      .name,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppTextStyles
                                                                      .bodyLargeSemiboldTextStyle,
                                                                ),
                                                                AppGaps.hGap5,
                                                                const Row(
                                                                  children: [
                                                                    SingleStarWidget(
                                                                        review:
                                                                            4.9),
                                                                    AppGaps
                                                                        .wGap4,
                                                                    Text(
                                                                      '(831 reviews)',
                                                                      style: AppTextStyles
                                                                          .smallestMediumTextStyle,
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  childCount: controller
                                                      .requestDetails
                                                      .requests
                                                      .length,
                                                ),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        crossAxisSpacing: 10,
                                                        mainAxisExtent: 70,
                                                        mainAxisSpacing: 10),
                                              )
                                            : SliverToBoxAdapter(
                                                child: Center(
                                                child: Text(
                                                  AppLanguageTranslation
                                                      .haveNoCoPassengerTransKey
                                                      .toCurrentLanguage,
                                                  style: AppTextStyles
                                                      .notificationDateSection
                                                      .copyWith(
                                                          color: AppColors
                                                              .bodyTextColor),
                                                ),
                                              )),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap16,
                                      ),
                                      if (controller.requestDetails.type ==
                                          'vehicle')
                                        SliverToBoxAdapter(
                                          child: Text(
                                            AppLanguageTranslation
                                                .vehicleInfoTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                        ),
                                      if (controller.requestDetails.type ==
                                          'vehicle')
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap8,
                                        ),
                                      if (controller.requestDetails.type ==
                                          'vehicle')
                                        SliverToBoxAdapter(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 100,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18))),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child:
                                                        CachedNetworkImageWidget(
                                                      imageURL: controller
                                                          .requestDetails
                                                          .category
                                                          .image,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            16)),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  ),
                                                  AppGaps.wGap10,
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .requestDetails
                                                            .category
                                                            .name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle,
                                                      ),
                                                      Text(
                                                        controller
                                                            .requestDetails
                                                            .vehicleNumber,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ))
                                          ],
                                        )),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap100,
                                      ),
                                    ],
                                  )),
                                ))
                              ]),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.mainBg,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomStretchedButtonWidget(
                        onTap: controller.onRequestRideButtonTap,
                        child: Text(AppLanguageTranslation
                            .requestRideTransKey.toCurrentLanguage),
                      ),
                    ],
                  )),
            )));
  }
}

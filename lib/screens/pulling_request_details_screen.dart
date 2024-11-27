import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/pulling_request_details_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_details_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PullingRequestDetailsScreen extends StatelessWidget {
  const PullingRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullingRequestDetailsScreenController>(
        global: false,
        init: PullingRequestDetailsScreenController(),
        builder: (controller) => WillPopScope(
              onWillPop: () async {
                controller.popScope();
                return await Future.value(true);
              },
              child: Scaffold(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: ScaffoldBodyWidget(
                                        child: CustomScrollView(
                                      slivers: [
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap10,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            height: 165,
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
                                                                  .offer
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
                                                              .offer
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
                                                              .offer
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
                                            controller.requestDetails.offer
                                                        .type ==
                                                    'passenger'
                                                ? AppLanguageTranslation
                                                    .passengerTransKey
                                                    .toCurrentLanguage
                                                : AppLanguageTranslation
                                                    .driverTransKey
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
                                            height: 90,
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
                                                      .requestDetails
                                                      .offer
                                                      .user
                                                      .image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
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
                                                          .offer.user.name,
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
                                                        Helper.getCurrencyFormattedWithDecimalAmountText(
                                                            controller
                                                                .requestDetails
                                                                .offer
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
                                                        controller
                                                            .requestDetails
                                                            .offer
                                                            .seats
                                                            .toString(),
                                                        style: AppTextStyles
                                                            .bodySmallSemiboldTextStyle,
                                                      ),
                                                      AppGaps.wGap5,
                                                      Text(
                                                        controller.requestDetails
                                                                    .offer.type ==
                                                                'passenger'
                                                            ? AppLanguageTranslation
                                                                .seatNeedTransKey
                                                                .toCurrentLanguage
                                                            : AppLanguageTranslation
                                                                .seatAvailableTransKey
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
                                              // RawButtonWidget(
                                              //   child: Container(
                                              //     height: 44,
                                              //     width: 44,
                                              //     decoration:
                                              //         const BoxDecoration(
                                              //             color: Colors.white,
                                              //             borderRadius:
                                              //                 BorderRadius.all(
                                              //                     Radius
                                              //                         .circular(
                                              //                             12))),
                                              //     child: const Center(
                                              //       child: SvgPictureAssetWidget(
                                              //           AppAssetImages
                                              //               .callingSVGLogoSolid),
                                              //     ),
                                              //   ),
                                              //   onTap: () {},
                                              // ),
                                              // AppGaps.wGap12,
                                              Expanded(
                                                  child:
                                                      CustomMessageTextFormField(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                AppPageNames
                                                                    .chatScreen,
                                                                arguments:
                                                                    controller
                                                                        .requestDetails
                                                                        .offer
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
                                                              .toCurrentLanguage))
                                            ],
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap16,
                                        ),
                                        if (controller
                                                .requestDetails.offer.type ==
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
                                        if (controller
                                                .requestDetails.offer.type ==
                                            'vehicle')
                                          controller.requestDetails.offer
                                                  .requests.isNotEmpty
                                              ? SliverGrid(
                                                  delegate:
                                                      SliverChildBuilderDelegate(
                                                    (BuildContext context,
                                                        int index) {
                                                      PullingRequestDetailsRequest
                                                          request = controller
                                                              .requestDetails
                                                              .offer
                                                              .requests[index];
                                                      return Container(
                                                        // height: 48,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14)),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 48,
                                                              width: 48,
                                                              child:
                                                                  CachedNetworkImageWidget(
                                                                imageURL:
                                                                    request.user
                                                                        .image,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          AppComponents
                                                                              .imageBorderRadius,
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
                                                                    request.user
                                                                        .name,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodyLargeSemiboldTextStyle,
                                                                  ),
                                                                  const Row(
                                                                    children: [
                                                                      SingleStarWidget(
                                                                          review:
                                                                              3),
                                                                      AppGaps
                                                                          .wGap4,
                                                                      Text(
                                                                        '(531 Rides)',
                                                                        style: AppTextStyles
                                                                            .bodySmallTextStyle,
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    childCount: controller
                                                        .requestDetails
                                                        .offer
                                                        .requests
                                                        .length,
                                                  ),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisExtent: 60,
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
                                        if (controller
                                                .requestDetails.offer.type ==
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
                                        if (controller
                                                .requestDetails.offer.type ==
                                            'vehicle')
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap8,
                                          ),
                                        if (controller
                                                .requestDetails.offer.type ==
                                            'vehicle')
                                          SliverToBoxAdapter(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                18))),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                        imageURL: controller
                                                            .requestDetails
                                                            .offer
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
                                                                      .all(
                                                                      Radius.circular(
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
                                                              .offer
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
                                                              .offer
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
                            Positioned(
                                top: 0,
                                left: 27,
                                child: Container(
                                  width: 90,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          controller.otp,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkColor),
                                        ),
                                        Text(
                                          AppLanguageTranslation
                                              .startOtpTransKey
                                              .toCurrentLanguage,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.bodyTextColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
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
                          onTap: controller.requestDetails.offer.type ==
                                  'vehicle'
                              ? controller.requestDetails.status == 'reject'
                                  ? null
                                  : controller.requestDetails.status ==
                                          'completed'
                                      ? null
                                      : controller.requestDetails.status ==
                                              'accepted'
                                          ? controller.onCancelTripButtonTap
                                          : controller.requestDetails.payment
                                                      .status ==
                                                  'paid'
                                              ? controller.reviewButtonTap
                                              : controller.onMakePaymentTap
                              : controller.requestDetails.status == 'completed'
                                  ? null
                                  : controller.requestDetails.status ==
                                          'cancelled'
                                      ? null
                                      : controller.onCancelTripButtonTap,
                          /* controller.requestDetails.status == 'completed'
                                    ? null
                                    : controller.pickUpPassengers.value
                                        ? controller.onCompleteRideButtonTap
                                        : controller.onStartRideButtonTap, */
                          child: Text(controller.requestDetails.offer.type ==
                                  'vehicle'
                              ? controller.requestDetails.status == 'completed'
                                  ? AppLanguageTranslation
                                      .sendFeedbackTransKey.toCurrentLanguage
                                  : controller.requestDetails.status == 'reject'
                                      ? AppLanguageTranslation
                                          .rejectedTransKey.toCurrentLanguage
                                      : controller.requestDetails.status ==
                                                  'accepted' ||
                                              controller.requestDetails.status ==
                                                  'pending'
                                          ? AppLanguageTranslation
                                              .cancelRideTransKey
                                              .toCurrentLanguage
                                          : controller.requestDetails.payment
                                                      .status ==
                                                  'paid'
                                              ? AppLanguageTranslation
                                                  .reviewTransKey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .makePaymentTransKey
                                                  .toCurrentLanguage
                              : controller.requestDetails.status == 'completed'
                                  ? AppLanguageTranslation
                                      .sendFeedbackTransKey.toCurrentLanguage
                                  : controller.requestDetails.status ==
                                          'cancelled'
                                      ? AppLanguageTranslation
                                          .requestCancelledTransKey
                                          .toCurrentLanguage
                                      : AppLanguageTranslation
                                          .cancelRideTransKey
                                          .toCurrentLanguage),
                        ),
                      ],
                    )),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/pulling_offer_details_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
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

class PullingOfferDetailsScreen extends StatelessWidget {
  const PullingOfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullingOfferDetailsScreenController>(
        init: PullingOfferDetailsScreenController(),
        global: false,
        builder: ((controller) => WillPopScope(
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
                                                                  .offerDetails
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
                                                              .offerDetails
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
                                                              .offerDetails
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
                                            controller.offerDetails.type ==
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
                                                      .offerDetails.user.image,
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
                                                      controller.offerDetails
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
                                                        Helper.getCurrencyFormattedWithDecimalAmountText(
                                                            controller
                                                                .offerDetails
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
                                                        '${controller.offerDetails.type == 'passenger' ? controller.offerDetails.seats : controller.offerDetails.available}',
                                                        style: AppTextStyles
                                                            .bodySmallSemiboldTextStyle,
                                                      ),
                                                      AppGaps.wGap5,
                                                      Text(
                                                        controller.offerDetails
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
                                        /* SliverToBoxAdapter(
                                          child: Row(
                                            children: [
                                              /*  RawButtonWidget(
                                                child: Container(
                                                  height: 44,
                                                  width: 44,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  child: const Center(
                                                    child: SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .callingSVGLogoSolid),
                                                  ),
                                                ),
                                                onTap: () {},
                                              ), */
                                              //=============need work===============
                                              /* AppGaps.wGap12,
                                              Expanded(
                                                  child:
                                                      CustomMessageTextFormField(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames.chatScreen,
                                                      arguments: controller
                                                          .offerDetails
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
                                              )) */
                                            ],
                                          ),
                                        ), */
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap16,
                                        ),
                                        // if (controller.requestDetails.type ==
                                        //     'vehicle')
                                        SliverToBoxAdapter(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.offerDetails.type ==
                                                        'passenger'
                                                    ? AppLanguageTranslation
                                                        .driverTransKey
                                                        .toCurrentLanguage
                                                    : AppLanguageTranslation
                                                        .passengerTransKey
                                                        .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .notificationDateSection,
                                              ),
                                              if (controller
                                                      .offerDetails.type !=
                                                  'passenger')
                                                RawButtonWidget(
                                                    onTap: () {
                                                      controller
                                                          .getRequestDetails();
                                                      controller.update();
                                                    },
                                                    child: Icon(Icons.replay)),
                                            ],
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap8,
                                        ),
                                        // if (controller.requestDetails.type ==
                                        //     'vehicle')
                                        controller.offerDetails.requests
                                                .isNotEmpty
                                            ? SliverList.separated(
                                                separatorBuilder:
                                                    (context, index) =>
                                                        AppGaps.hGap10,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  PullingOfferDetailsRequest
                                                      request = controller
                                                          .requests[index];
                                                  return Container(
                                                    height: 265,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 45,
                                                              width: 45,
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
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          request
                                                                              .user
                                                                              .name,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              AppTextStyles.bodyLargeSemiboldTextStyle,
                                                                        ),
                                                                      ),
                                                                      if (controller
                                                                              .offerDetails
                                                                              .type ==
                                                                          "vehicle")
                                                                        AppGaps
                                                                            .wGap5,
                                                                      if (request.seats >
                                                                              1 &&
                                                                          controller.offerDetails.type ==
                                                                              "vehicle")
                                                                        const Text(
                                                                          '+',
                                                                          style:
                                                                              AppTextStyles.bodyLargeSemiboldTextStyle,
                                                                        ),
                                                                      if (controller
                                                                              .offerDetails
                                                                              .type ==
                                                                          "vehicle")
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children:
                                                                                List.generate(request.seats > 2 ? 3 : request.seats - 1, (index) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                                                                child: Container(
                                                                                  width: 19, // Adjust the size of the dot as needed
                                                                                  height: 19,
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Color(0xFFD9D9D9),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                          ),
                                                                        )
                                                                    ],
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
                                                            if (controller
                                                                    .offerDetails
                                                                    .type ==
                                                                'vehicle')
                                                              Obx(() => controller
                                                                      .pickUpPassengers
                                                                      .value
                                                                  ? InkWell(
                                                                      onTap: () => controller.onPickupButtonTap(
                                                                          request,
                                                                          payment:
                                                                              request.payment),
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                7,
                                                                            horizontal:
                                                                                16),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            color: request.status == 'accepted'
                                                                                ? AppColors.primaryColor
                                                                                : request.status == 'started'
                                                                                    ? AppColors.darkColor
                                                                                    : request.status == 'completed'
                                                                                        ? AppColors.bodyTextColor
                                                                                        : AppColors.alertColor),
                                                                        child:
                                                                            Text(
                                                                          request.status == 'accepted'
                                                                              ? AppLanguageTranslation.pickTransKey.toCurrentLanguage
                                                                              : request.status == 'started'
                                                                                  ? AppLanguageTranslation.dropTransKey.toCurrentLanguage
                                                                                  : request.status == 'completed'
                                                                                      ? AppLanguageTranslation.completedTransKey.toCurrentLanguage
                                                                                      : AppLanguageTranslation.unknownTransKey.toCurrentLanguage,
                                                                          style: AppTextStyles
                                                                              .bodySemiboldTextStyle
                                                                              .copyWith(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              '${Helper.getCurrencyFormattedWithDecimalAmountText(request.rate)} ',
                                                                              style: AppTextStyles.bodySmallSemiboldTextStyle,
                                                                            ),
                                                                            Text(
                                                                              ' / ${AppLanguageTranslation.perSeatTransKey.toCurrentLanguage}',
                                                                              style: AppTextStyles.bodySmallSemiboldTextStyle.copyWith(color: AppColors.bodyTextColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        AppGaps
                                                                            .hGap6,
                                                                        Row(
                                                                          children: [
                                                                            const SvgPictureAssetWidget(
                                                                              AppAssetImages.seat,
                                                                              height: 10,
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              ' ${request.seats}  seat${request.seats > 1 ? "s" : ""}',
                                                                              style: AppTextStyles.smallestSemiboldTextStyle.copyWith(color: AppColors.bodyTextColor),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )),
                                                          ],
                                                        ),
                                                        if (controller
                                                                .offerDetails
                                                                .type ==
                                                            'vehicle')
                                                          AppGaps.hGap12,
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
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
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodySmallTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.bodyTextColor),
                                                                  ),
                                                                  AppGaps.hGap4,
                                                                  Text(
                                                                    controller
                                                                        .offerDetails
                                                                        .from
                                                                        .address,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
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
                                                              CrossAxisAlignment
                                                                  .end,
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
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodySmallTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.bodyTextColor),
                                                                  ),
                                                                  AppGaps.hGap4,
                                                                  Text(
                                                                    controller
                                                                        .offerDetails
                                                                        .to
                                                                        .address,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodyLargeMediumTextStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        AppGaps.hGap18,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    CustomMessageTextFormField(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    AppPageNames
                                                                        .chatScreen,
                                                                    arguments:
                                                                        request
                                                                            .user
                                                                            .id);
                                                              },
                                                              isReadOnly: true,
                                                              suffixIcon: const SvgPictureAssetWidget(
                                                                  AppAssetImages
                                                                      .sendSVGLogoLine),
                                                              boxHeight: 44,
                                                              hintText: AppLanguageTranslation
                                                                  .messageYourDriverTransKey
                                                                  .toCurrentLanguage,
                                                            )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount:
                                                    controller.requests.length,

                                                /* gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        crossAxisSpacing: 10,
                                                        mainAxisExtent: 70,
                                                        mainAxisSpacing: 10), */
                                              )
                                            : SliverToBoxAdapter(
                                                child: Center(
                                                child: Text(
                                                  controller.offerDetails
                                                              .type ==
                                                          'passenger'
                                                      ? AppLanguageTranslation
                                                          .haveNoDriverTransKey
                                                          .toCurrentLanguage
                                                      : AppLanguageTranslation
                                                          .haveNoPassengerTransKey
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
                                        if (controller.offerDetails.type ==
                                            'passenger')
                                          SliverToBoxAdapter(
                                            child: Text(
                                              AppLanguageTranslation
                                                  .vehicleInfoTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .notificationDateSection,
                                            ),
                                          ),
                                        if (controller.offerDetails.type ==
                                            'passenger')
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap8,
                                          ),
                                        if (controller.offerDetails.type ==
                                            'passenger')
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
                                                                .offerDetails
                                                                .requests
                                                                .firstOrNull
                                                                ?.category
                                                                .image ??
                                                            '',
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
                                                                  .offerDetails
                                                                  .requests
                                                                  .firstOrNull
                                                                  ?.category
                                                                  .name ??
                                                              '',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyLargeSemiboldTextStyle,
                                                        ),
                                                        Text(
                                                          controller
                                                                  .offerDetails
                                                                  .requests
                                                                  .firstOrNull
                                                                  ?.vehicleNumber ??
                                                              '',
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
                    child: Obx(() => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomStretchedButtonWidget(
                              onTap: controller.offerDetails.type == 'passenger'
                                  ? controller.offerDetails.status ==
                                          'completed'
                                      ? null
                                      : controller
                                                  .offerDetails
                                                  .requests
                                                  .firstOrNull
                                                  ?.payment
                                                  .status ==
                                              'paid'
                                          ? controller.offerDetails.requests
                                                      .firstOrNull?.status ==
                                                  'completed'
                                              ? null
                                              : () => controller.dropPassenger(
                                                  controller
                                                          .offerDetails
                                                          .requests
                                                          .firstOrNull ??
                                                      PullingOfferDetailsRequest
                                                          .empty())
                                          : controller.offerDetails.requests
                                                      .firstOrNull?.status ==
                                                  'accepted'
                                              ? controller.onStartTripTap
                                              : controller.onMakePaymentTap
                                  : controller.offerDetails.status ==
                                          'completed'
                                      ? null
                                      : controller.pickUpPassengers.value
                                          ? controller.onCompleteRideButtonTap
                                          : controller.requests.isEmpty
                                              ? null
                                              : controller.onStartRideButtonTap,
                              /* controller.offerDetails.status == 'completed'
                                  ? null
                                  : controller.pickUpPassengers.value
                                      ? controller.onCompleteRideButtonTap
                                      : controller.offerDetails.type ==
                                              'passenger'
                                          ? () => controller.onPickupButtonTap(
                                              controller.offerDetails.requests[0])
                                          : controller.onStartRideButtonTap */
                              child: Text(controller.offerDetails.type ==
                                      'passenger'
                                  ? controller.offerDetails.status ==
                                          'completed'
                                      ? AppLanguageTranslation
                                          .tripIsCompletedTransKey
                                          .toCurrentLanguage
                                      : controller
                                                  .offerDetails
                                                  .requests
                                                  .firstOrNull
                                                  ?.payment
                                                  .status ==
                                              'paid'
                                          ? controller.offerDetails.requests
                                                      .firstOrNull?.status ==
                                                  'completed'
                                              ? AppLanguageTranslation
                                                  .tripIsCompletedTransKey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .completeTripTransKey
                                                  .toCurrentLanguage
                                          : controller.offerDetails.requests
                                                      .firstOrNull?.status ==
                                                  'accepted'
                                              ? AppLanguageTranslation
                                                  .startTripTransKey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .makePaymentTransKey
                                                  .toCurrentLanguage
                                  : controller.offerDetails.status == 'completed'
                                      ? AppLanguageTranslation.rideIsCompleteTransKey.toCurrentLanguage
                                      : controller.pickUpPassengers.value
                                          ? AppLanguageTranslation.completeRideTransKey.toCurrentLanguage
                                          : AppLanguageTranslation.startRideTransKey.toCurrentLanguage),
                            ),
                          ],
                        ))),
              ),
            )));
  }
}

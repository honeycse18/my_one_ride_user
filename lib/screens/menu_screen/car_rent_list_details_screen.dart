import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/car_rent_list_screen_details_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class CarRentListDetailsScreen extends StatelessWidget {
  const CarRentListDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarRentListDetailsScreenController>(
        global: false,
        init: CarRentListDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                      controller.rentCarListDetails.vehicle.category.name)),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap10,
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      AppLanguageTranslation
                          .vehicleInfoTransKey.toCurrentLanguage,
                      style: AppTextStyles.notificationDateSection,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap12,
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: Colors.white),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CachedNetworkImageWidget(
                              imageURL: Helper.getFirstSafeString(
                                  controller.rentCarListDetails.vehicle.images),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          AppGaps.wGap12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .rentCarListDetails.vehicle.category.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                ),
                                AppGaps.hGap10,
                                Text(
                                  controller.rentCarListDetails.vehicle.uid,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyTextStyle
                                      .copyWith(color: AppColors.bodyTextColor),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      AppLanguageTranslation.carOwnerTransKey.toCurrentLanguage,
                      style: AppTextStyles.notificationDateSection,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap12,
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 70,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: Colors.white),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImageWidget(
                              imageURL:
                                  controller.rentCarListDetails.owner.image,
                              imageBuilder: (context, imageProvider) =>
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
                          AppGaps.wGap12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.rentCarListDetails.owner.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                ),
                                AppGaps.hGap5,
                                const Row(
                                  children: [
                                    SingleStarWidget(review: 3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap12,
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        /* RawButtonWidget(
                          borderRadiusValue: 12,
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: AppColors.primaryBorderColor)),
                            child: const Center(
                                child: SvgPictureAssetWidget(
                                    AppAssetImages.callingSVGLogoSolid)),
                          ),
                          onTap: () {},
                        ),
                        AppGaps.wGap8, */
                        Expanded(
                            child: CustomMessageTextFormField(
                          onTap: () {
                            Get.toNamed(AppPageNames.chatScreen,
                                arguments:
                                    controller.rentCarListDetails.owner.id);
                          },
                          isReadOnly: true,
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.sendSVGLogoLine),
                          boxHeight: 55,
                          hintText: AppLanguageTranslation
                              .messageYourDriverTransKey.toCurrentLanguage,
                        ))
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap12,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      height: 145,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .startDateTimeTransKey.toCurrentLanguage,
                                  style: AppTextStyles.bodyLargeTextStyle
                                      .copyWith(color: AppColors.bodyTextColor),
                                ),
                                Text(
                                  Helper.ddMMMyyyyhhmmaFormattedDateTime(
                                      controller.rentCarListDetails.date),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyLargeTextStyle,
                                ),
                              ],
                            ),
                            AppGaps.hGap24,
                            Text(
                              AppLanguageTranslation
                                  .carCollectionPointTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap4,
                            Row(
                              children: [
                                const SvgPictureAssetWidget(
                                  AppAssetImages.locateSVGLogoLine,
                                  color: AppColors.primaryColor,
                                ),
                                AppGaps.wGap8,
                                Expanded(
                                  child: Text(
                                    controller.rentCarListDetails.rent.address,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
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
                  if (controller.rentCarListDetails.status == 'accepted')
                    SliverToBoxAdapter(
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(12),
                          height: 64,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLanguageTranslation
                                          .otpTransKey.toCurrentLanguage,
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle,
                                    ),
                                    Text(
                                      controller.rentCarListDetails.otp,
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle,
                                    ),
                                  ]),
                              Text(
                                AppLanguageTranslation
                                    .shareWithDriverTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              )
                            ],
                          ),
                        ))
                      ]),
                    ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 180,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .paymentDetailsTransKey.toCurrentLanguage,
                                style: AppTextStyles
                                    .titleSemiSmallSemiboldTextStyle,
                              ),
                              AppGaps.hGap8,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .totalTimeTransKey.toCurrentLanguage,
                                    style: AppTextStyles
                                        .bodyLargeMediumTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor),
                                  ),
                                  Row(
                                    children: [
                                      controller.rentCarListDetails.type ==
                                              'hourly'
                                          ? Text(
                                              '${controller.rentCarListDetails.quantity} hour',
                                              style: AppTextStyles
                                                  .bodyLargeMediumTextStyle,
                                            )
                                          : controller.rentCarListDetails
                                                      .type ==
                                                  'weekly'
                                              ? Text(
                                                  '${controller.rentCarListDetails.quantity} week',
                                                  style: AppTextStyles
                                                      .bodyLargeMediumTextStyle,
                                                )
                                              : Text(
                                                  '${controller.rentCarListDetails.quantity} month',
                                                  style: AppTextStyles
                                                      .bodyLargeMediumTextStyle,
                                                ),
                                    ],
                                  ),
                                ],
                              ),
                              AppGaps.hGap8,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .amountTransKey.toCurrentLanguage,
                                    style: AppTextStyles
                                        .bodyLargeMediumTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          controller.rentCarListDetails.currency
                                              .symbol,
                                          style: AppTextStyles
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor)),
                                      AppGaps.wGap4,
                                      Text(
                                          controller.rentCarListDetails.total
                                              .toStringAsFixed(2),
                                          style: AppTextStyles
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor)),
                                    ],
                                  ),
                                ],
                              ),
                              AppGaps.hGap8,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .discountTransKey.toCurrentLanguage,
                                    style: AppTextStyles
                                        .bodyLargeMediumTextStyle
                                        .copyWith(color: AppColors.alertColor),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          controller.rentCarListDetails.currency
                                              .symbol,
                                          style: AppTextStyles
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                  color: AppColors.alertColor)),
                                      AppGaps.wGap4,
                                      Text(0.toStringAsFixed(2),
                                          style: AppTextStyles
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                  color: AppColors.alertColor)),
                                    ],
                                  ),
                                ],
                              ),
                              AppGaps.hGap12,
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 1,
                                    decoration: const BoxDecoration(
                                        color: AppColors.primaryBorderColor),
                                  ))
                                ],
                              ),
                              AppGaps.hGap12,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .grantTotalTransKey.toCurrentLanguage,
                                    style: AppTextStyles.bodyBoldTextStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          controller.rentCarListDetails.currency
                                              .symbol,
                                          style:
                                              AppTextStyles.bodyBoldTextStyle),
                                      AppGaps.wGap4,
                                      Text(
                                          controller.rentCarListDetails.total
                                              .toStringAsFixed(2),
                                          style:
                                              AppTextStyles.bodyBoldTextStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 47,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryBorderColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              )),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .paymentMethodTransKey.toCurrentLanguage,
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                                Text(
                                  controller.rentCarListDetails.payment.method
                                      .toUpperCase(),
                                  style: AppTextStyles.bodyTextStyle,
                                ),
                              ]),
                        ))
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                ],
              )),
              bottomNavigationBar: CustomScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.rentCarListDetails.status == 'started'
                      ? CustomStretchedButtonWidget(
                          child: Text(AppLanguageTranslation
                              .sendFeedbackTransKey.toCurrentLanguage),
                        )
                      : controller.rentCarListDetails.status == 'completed'
                          ? CustomStretchedTextButtonWidget(
                              buttonText: AppLanguageTranslation
                                  .sendFeedbackTransKey.toCurrentLanguage,
                              onTap: controller.submitReview,
                            )
                          : AppGaps.emptyGap,
                  AppGaps.hGap10,
                ],
              )),
            ));
  }
}

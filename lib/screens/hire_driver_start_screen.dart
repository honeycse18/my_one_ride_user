import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:one_ride_user/controller/hire_driver_start_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class HireDriverStartScreen extends StatelessWidget {
  const HireDriverStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverStartScreenController>(
      init: HireDriverStartScreenController(),
      global: false,
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleWidget: Text(controller.hiredDriverDetails.driver.name)),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGaps.hGap20,
                // Create a circle with text on middle
                CircleWithTextWidget(
                  text: controller.getElapsedTime(),
                  radius: 65.5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        AppLanguageTranslation
                            .workingHourTransKey.toCurrentLanguage,
                        style: AppTextStyles.titleSmallBoldTextStyle),
                  ],
                ),
                AppGaps.hGap16,
                DriverDescriptionWithPrice(
                  profilePhotoUrl: controller.hiredDriverDetails.driver.image,
                  name: controller.hiredDriverDetails.driver.name,
                  ratings: 3.0,
                  symbol: controller.hiredDriverDetails.currency.symbol,
                  price: controller.hiredDriverDetails.amount.toString(),
                ),
                AppGaps.hGap16,
                OTPWidget(
                  otp: controller.hiredDriverDetails.otp,
                ),
                AppGaps.hGap16,
                Row(
                  children: [
                    // RawButtonWidget(
                    //   borderRadiusValue: 12,
                    //   child: Container(
                    //     height: 55,
                    //     width: 55,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(12)),
                    //         border: Border.all(
                    //             color: AppColors.primaryBorderColor)),
                    //     child: const Center(
                    //         child: SvgPictureAssetWidget(
                    //             AppAssetImages.callingSVGLogoSolid)),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // AppGaps.wGap8,
                    Expanded(
                        child: CustomMessageTextFormField(
                      onTap: () {
                        Get.toNamed(AppPageNames.chatScreen,
                            arguments: controller.hiredDriverDetails.driver.id);
                      },
                      isReadOnly: true,
                      suffixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.sendSVGLogoLine),
                      boxHeight: 55,
                      hintText: AppLanguageTranslation
                          .messageTransKey.toCurrentLanguage,
                    ))
                  ],
                ),
                AppGaps.hGap24,
                StartDateTimeWithLocation(
                  startTime: controller.hiredDriverDetails.startTime,
                  location: controller.hiredDriverDetails.pickup,
                ),
                /* AppGaps.hGap27,
                const Text("Apply Coupon",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                AppGaps.hGap13,
                const CouponCodeWidget(), */
                AppGaps.hGap27,
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(16),
                      height: 160,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .paymentDetailsTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                          AppGaps.hGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .amountTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyLargeMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              Row(
                                children: [
                                  Text(
                                      controller
                                          .hiredDriverDetails.currency.symbol,
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle),
                                  AppGaps.wGap4,
                                  Text(
                                      controller
                                          .hiredDriverDetails.payment.amount
                                          .toStringAsFixed(2),
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .discountTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyLargeMediumTextStyle
                                    .copyWith(color: AppColors.alertColor),
                              ),
                              Row(
                                children: [
                                  Text(
                                      controller
                                          .hiredDriverDetails.currency.symbol,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .totalAmountTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyBoldTextStyle,
                              ),
                              Row(
                                children: [
                                  Text(
                                      controller
                                          .hiredDriverDetails.currency.symbol,
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle),
                                  AppGaps.wGap4,
                                  Text(
                                      controller
                                          .hiredDriverDetails.payment.amount
                                          .toStringAsFixed(2),
                                      style: AppTextStyles
                                          .bodyLargeMediumTextStyle),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
                AppGaps.hGap27,
              ],
            ),
          ),
        ),
        bottomNavigationBar: ScaffoldBottomBarWidget(
            child: controller.hiredDriverDetails.status == 'started'
                ? CustomStretchedButtonWidget(
                    child: Text(AppLanguageTranslation
                        .startedTransKey.toCurrentLanguage))
                : controller.hiredDriverDetails.status == 'break'
                    ? CustomStretchedButtonWidget(
                        child: Text(AppLanguageTranslation
                            .breakTransKey.toCurrentLanguage))
                    : controller.hiredDriverDetails.status == 'completed'
                        ? controller.hiredDriverDetails.payment.transactionId ==
                                ''
                            ? CustomStretchedTextButtonWidget(
                                buttonText:
                                    '${AppLanguageTranslation.paymentTransKey.toCurrentLanguage} -> ${controller.hiredDriverDetails.currency.symbol} ${controller.hiredDriverDetails.amount}',
                                onTap: () {
                                  // Payment screen
                                  Get.toNamed(
                                      AppPageNames
                                          .hireDriverSelectPaymentMethodsScreen,
                                      arguments:
                                          controller.hiredDriverDetails.id);
                                },
                              )
                            : CustomStretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .reviewDriverTransKey.toCurrentLanguage,
                                onTap: controller.submitReview,
                              )
                        : AppGaps.emptyGap),
      ),
    );
  }
}

class CouponCodeWidget extends StatelessWidget {
  const CouponCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Expanded(
          child: CustomMessageTextFormField(
        onTap: () {},
        isReadOnly: false,
        suffixIcon:
            const SvgPictureAssetWidget(AppAssetImages.applyCouponSVGSolidIcon),
        boxHeight: 55,
        hintText: AppLanguageTranslation.couponCodeTransKey.toCurrentLanguage,
      )),
    );
  }
}

class StartDateTimeWithLocation extends StatelessWidget {
  final DateTime startTime;
  final String location;
  const StartDateTimeWithLocation({
    Key? key,
    required this.startTime,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLanguageTranslation.startDateTimeTransKey.toCurrentLanguage,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
            ),
            Text(
              Helper.ddMMMyyyyhhmmaFormattedDateTime(startTime),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeTextStyle,
            ),
          ],
        ),
        AppGaps.hGap24,
        Text(
          AppLanguageTranslation.pickUpTransKey.toCurrentLanguage,
          style: AppTextStyles.bodySmallTextStyle
              .copyWith(color: AppColors.bodyTextColor),
        ),
        AppGaps.hGap4,
        Row(
          children: [
            const SvgPictureAssetWidget(
              AppAssetImages.pickLocationSVGLogoLine,
              color: AppColors.primaryColor,
            ),
            AppGaps.wGap8,
            Expanded(
              child: Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class OTPWidget extends StatelessWidget {
  final String otp;

  const OTPWidget({
    super.key,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
        padding: const EdgeInsets.all(12),
        height: 64,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                AppLanguageTranslation.otpTransKey.toCurrentLanguage,
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
              Text(
                otp,
                // controller.rentCarListDetails.otp,
                style: AppTextStyles.bodyLargeBoldTextStyle,
              ),
            ]),
            Text(
              AppLanguageTranslation.shareWithDriverTransKey.toCurrentLanguage,
              style: AppTextStyles.bodyTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
            )
          ],
        ),
      ))
    ]);
  }
}

class DriverDescriptionWithPrice extends StatelessWidget {
  final String profilePhotoUrl;
  final String name;
  final double ratings;
  final String price;
  final String symbol;

  const DriverDescriptionWithPrice({
    super.key,
    required this.profilePhotoUrl,
    required this.name,
    required this.ratings,
    required this.price,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CachedNetworkImageWidget(
              imageURL: profilePhotoUrl,
              imageBuilder: (context, imageProvider) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          AppGaps.wGap12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap5,
                Row(
                  children: [
                    SingleStarWidget(review: ratings),
                  ],
                ),
              ],
            ),
          ),
          AppGaps.wGap10,
          Row(
            children: [
              Text(
                symbol,
                style: AppTextStyles.bodyBoldTextStyle,
              ),
              AppGaps.wGap5,
              Text(
                price,
                style: AppTextStyles.bodyBoldTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleWithTextWidget extends StatelessWidget {
  final String text;
  final double radius;

  const CircleWithTextWidget({
    Key? key,
    required this.text,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: radius * 2.5,
                height: radius * 2.5,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 22.08,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

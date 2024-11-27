import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class AppDialogs {
  /* static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ?? 'Success';
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.successBackgroundColor,
      titleWidget: Text(dialogTitle,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: AppColors.successColor),
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText: '',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        )
      ],
    ));
  } */
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.successIconImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        /* CustomStretchedTextButtonWidget(
          buttonText: 'Okay',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        ) */
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showExpireDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> rentPaymentSuccessDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    required Future<void> Function() onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(AppAssetImages.paymentSuccessDialougIconImage),
            AppGaps.hGap16,
            Center(
              child: Text(
                  titleText ??
                      AppLanguageTranslation
                          .rentSuccessFulTransKey.toCurrentLanguage,
                  style: AppTextStyles.titleSmallSemiboldTextStyle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Text(messageText,
            style: AppTextStyles.bodyLargeSemiboldTextStyle,
            textAlign: TextAlign.center),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.goHomeTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onNoTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??= AppLanguageTranslation
                      .viewBookingTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<Object?> shareRideSuccessDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() homeButtonTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String homeButtonText = 'Go Home',
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(
              AppAssetImages.paymentSuccessDialougIconImage,
              color: AppColors.primaryColor,
            ),
            AppGaps.hGap16,
            Center(
              child: Text(
                  titleText ??
                      AppLanguageTranslation
                          .requestSendSuccessfulTransKey.toCurrentLanguage,
                  style: AppTextStyles.titleSmallSemiboldTextStyle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Text(messageText,
            style: AppTextStyles.bodyLargeSemiboldTextStyle,
            textAlign: TextAlign.center),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: homeButtonText,
                  onTap: () async {
                    await homeButtonTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(AppAssetImages.confirmIconImage),
            AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget:
            Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation
                          .noAllowedTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation
                          .yesAllowedTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<Object?> showConfirmPaymentDialog({
    String titleText = '',
    required double amount,
    required double totalAmount,
    required String symbol,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String noButtonText = 'Cancel',
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: AppColors.mainBg,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap16,
            Center(
              child: Text(titleText,
                  style: AppTextStyles.titleSmallSemiboldTextStyle
                      .copyWith(color: const Color(0xFF3B82F6)),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(24),
              height: 170,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLanguageTranslation
                        .paymentDetailsTransKey.toCurrentLanguage,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguageTranslation.amountTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Row(
                        children: [
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
                          AppGaps.wGap4,
                          Text(amount.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
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
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.alertColor)),
                          AppGaps.wGap4,
                          Text(0.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.alertColor)),
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
                            .grantTotalTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyBoldTextStyle,
                      ),
                      Row(
                        children: [
                          Text(symbol, style: AppTextStyles.bodyBoldTextStyle),
                          AppGaps.wGap4,
                          Text(totalAmount.toStringAsFixed(2),
                              style: AppTextStyles.bodyBoldTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation
                          .confirmToPayTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<Object?> showActionableDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.alertColor,
      String? buttonText,
      int? waitTime,
      bool barrierDismissible = true,
      void Function()? onTap}) async {
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        AlertDialogWidget(
          backgroundColor: AppColors.alertBackgroundColor,
          titleWidget: Text(
              titleText ??
                  AppLanguageTranslation.errorTransKey.toCurrentLanguage,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: titleTextColor),
              textAlign: TextAlign.center),
          contentWidget: Text(messageText,
              style: AppTextStyles.bodyLargeSemiboldTextStyle),
          actionWidgets: [
            CustomStretchedTextButtonWidget(
              buttonText: buttonText ??
                  AppLanguageTranslation.okTransKey.toCurrentLanguage,
              // backgroundColor: AppColors.alertColor,
              onTap: onTap,
            )
          ],
        ));
  }

  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              AppLanguageTranslation.imageProcessingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<Object?> showProcessingDialog({String? message}) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              message ??
                  AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }
}

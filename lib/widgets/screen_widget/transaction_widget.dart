import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class TransactionWidget extends StatelessWidget {
  final String transactionName;
  final DateTime date;
  final DateTime time;
  final double amount;
  final String transactionType;
  final String symbol;
  final bool isEarned;

  const TransactionWidget({
    super.key,
    required this.transactionType,
    required this.date,
    required this.time,
    required this.amount,
    required this.transactionName,
    required this.isEarned,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
                child: isEarned
                    ? const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowUpSVGLogoSolid)
                    : const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowDownSVGLogoSolid)),
          ),
          AppGaps.wGap8,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionName == 'add_money'
                    ? AppLanguageTranslation.tpUpTransKey.toCurrentLanguage
                    : Helper.formatTransactionName(
                        transactionName) /* transactionName == 'ride'
                        ? AppLanguageTranslation
                            .rdePaymentTransKey.toCurrentLanguage
                        : transactionName == 'rent'
                            ? AppLanguageTranslation
                                .rentPaymentTransKey.toCurrentLanguage
                            : AppLanguageTranslation
                                .withdrawTransKey.toCurrentLanguage */
                ,
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
              Text(
                '${Helper.ddMMMyyyyFormattedDateTime(date)}| ${Helper.hhMMaFormattedDate(time)}',
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    symbol,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                  AppGaps.wGap4,
                  Text(
                    amount.toString(),
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                ],
              ),
              Text(
                transactionType,
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WithdrawTransactionWidget extends StatelessWidget {
  final String transactionName;
  final DateTime date;
  final DateTime time;
  final double amount;
  final String transactionType;
  final String symbol;
  final bool isEarned;

  const WithdrawTransactionWidget({
    super.key,
    required this.transactionType,
    required this.date,
    required this.time,
    required this.amount,
    required this.transactionName,
    required this.isEarned,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
                child: isEarned
                    ? const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowUpSVGLogoSolid)
                    : const SvgPictureAssetWidget(
                        AppAssetImages.solidAllowDownSVGLogoSolid)),
          ),
          AppGaps.wGap8,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionName.toUpperCase(),
                style: AppTextStyles.bodyLargeMediumTextStyle,
              ),
              Text(
                '${Helper.ddMMMyyyyFormattedDateTime(date)}| ${Helper.hhMMaFormattedDate(time)}',
                style: AppTextStyles.bodyTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    symbol,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                  AppGaps.wGap4,
                  Text(
                    amount.toString(),
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                height: 23,
                decoration: BoxDecoration(
                    color: transactionType == 'pending'
                        ? AppColors.secondaryColor.withOpacity(0.2)
                        : transactionType == 'completed'
                            ? AppColors.successColor.withOpacity(0.2)
                            : AppColors.alertColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Center(
                  child: Text(
                    transactionType == 'pending'
                        ? 'Pending'
                        : transactionType == 'completed'
                            ? 'Completed'
                            : transactionType,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.bodyTextStyle.copyWith(
                        color: transactionType == 'pending'
                            ? AppColors.secondaryColor
                            : transactionType == 'completed'
                                ? AppColors.successColor
                                : AppColors.alertColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

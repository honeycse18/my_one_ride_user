import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class OfferScreenWidget extends StatelessWidget {
  final int discount;
  final void Function() onTap;

  const OfferScreenWidget({
    super.key,
    required this.discount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '$discount% off',
                style: AppTextStyles.bodyLargeMediumTextStyle
                    .copyWith(color: AppColors.primaryColor),
              ),
              AppGaps.hGap5,
              Text('Black Friday',
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor)),
            ],
          ),
          CustomTightTextButtonWidget(
            onTap: onTap,
            child: Container(
              height: 34,
              width: 96,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                  child: Text(
                'Collect',
                style: AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';

class VehicleFeaturesWidget extends StatelessWidget {
  final String featuresName;
  final String featuresvalue;
  const VehicleFeaturesWidget({
    super.key,
    required this.featuresName,
    required this.featuresvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          height: 62,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featuresName,
                style: AppTextStyles.bodyLargeTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
              Text(featuresvalue, style: AppTextStyles.bodyLargeMediumTextStyle)
            ],
          )),
        ))
      ],
    );
  }
}

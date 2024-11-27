import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class SelectCarWidget extends StatelessWidget {
  final String transportName;
  final double amount;
  final int seat;
  final String carImage;
  final String vehicleCategory;
  final String fuelType;
  final String distanceInTime;
  final void Function() onTap;
  final bool isSelected;

  const SelectCarWidget({
    super.key,
    required this.vehicleCategory,
    required this.amount,
    required this.seat,
    required this.carImage,
    required this.transportName,
    required this.fuelType,
    required this.distanceInTime,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        height: 105,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: CachedNetworkImage(
                      imageUrl: carImage.isNotEmpty
                          ? carImage
                          : 'https://static.vecteezy.com/system/resources/previews/001/193/930/non_2x/vintage-car-png.png')),
            ),
            AppGaps.wGap8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            transportName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                        ),
                        Text(
                          Helper.getCurrencyFormattedWithDecimalAmountText(
                              amount),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyLargeMediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$vehicleCategory  |  $seat seats  |  $fuelType',
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      distanceInTime.isNotEmpty
                          ? "$distanceInTime away"
                          : AppLanguageTranslation
                              .carIsHereTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyMediumTextStyle
                          .copyWith(color: AppColors.secondaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectHomeCarWidget extends StatelessWidget {
  final String transportName;
  final double amount;
  final int seat;
  final String carImage;
  final String vehicleCategory;
  final String fuelType;
  final String distanceInTime;
  final void Function() onTap;
  final bool isSelected;

  const SelectHomeCarWidget({
    super.key,
    required this.vehicleCategory,
    required this.amount,
    required this.seat,
    required this.carImage,
    required this.transportName,
    required this.fuelType,
    required this.distanceInTime,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        height: 105,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 130,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: carImage.isNotEmpty
                      ? carImage
                      : 'https://github.com/Appstick-Ltd/oneRide-driver-flutter/assets/82593116/730ccd28-9fb2-487b-a104-a1e7ed18d8d2'),
            ),
            AppGaps.wGap8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            transportName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$vehicleCategory  |  $seat seats  |  $fuelType',
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      distanceInTime.isNotEmpty
                          ? "$distanceInTime away"
                          : AppLanguageTranslation
                              .carIsHereTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyMediumTextStyle
                          .copyWith(color: AppColors.secondaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCarCategoryPagesWidget extends StatelessWidget {
  final String transportName;
  final String tagline;
  final String image;
  final void Function()? onTap;

  const SelectCarCategoryPagesWidget({
    super.key,
    required this.tagline,
    required this.transportName,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      paddingValue: EdgeInsets.zero,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        // height: 100,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: CachedNetworkImage(
                      imageUrl: image.isNotEmpty
                          ? image
                          : 'https://static.vecteezy.com/system/resources/previews/001/193/930/non_2x/vintage-car-png.png')),
            ),
            AppGaps.wGap8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transportName,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  AppGaps.hGap8,
                  Text(
                    tagline,
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.secondaryTextColor),
                  ),
                ],
              ),
            ),
            const SvgPictureAssetWidget(AppAssetImages.arrowRightSVGLogoLine)
          ],
        ),
      ),
    );
  }
}

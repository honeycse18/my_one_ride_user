// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

/// Payment option list tile widget from checkout screen
class PaymentOptionListTileWidget extends StatelessWidget {
  const PaymentOptionListTileWidget({
    super.key,
    // required this.hasShadow,
    // required this.paymentIconWidget,
    required this.paymentName,
    // required this.id,
    // required this.selectedPaymentOptionId,
    // required this.radioOnChange,
    this.onTap,
    required this.paymentImageURL,
  });

  // final bool hasShadow;
  // final Widget paymentIconWidget;
  final String paymentImageURL;
  final String paymentName;
  // final String id;
  // final String selectedPaymentOptionId;
  // final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        // hasShadow: hasShadow,
        paddingValue: const EdgeInsets.all(8),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 62,
              width: 62,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.shadeColor1,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              // child: paymentIconWidget,
              child: CachedNetworkImageWidget(imageURL: paymentImageURL),
            ),
            AppGaps.wGap16,
            Expanded(
                child: Text(
              paymentName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )),
            AppGaps.wGap16,
            /* CustomRadioWidget(
                value: id,
                groupValue: selectedPaymentOptionId,
                onChanged: radioOnChange) */
          ],
        ));
  }
}

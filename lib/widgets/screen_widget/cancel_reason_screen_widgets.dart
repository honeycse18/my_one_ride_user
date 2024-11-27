import 'package:flutter/material.dart';
import 'package:one_ride_user/models/fakeModel/intro_content_model.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

/// Payment option list tile widget from checkout screen
class CancelReasonOptionListTileWidget extends StatelessWidget {
  const CancelReasonOptionListTileWidget({
    super.key,
    required this.hasShadow,
    required this.reasonName,
    required this.index,
    required this.selectedPaymentOptionIndex,
    required this.radioOnChange,
    this.onTap,
    required this.cancelReason,
    required this.selectedCancelReason,
  });

  final bool hasShadow;
  final String reasonName;
  final int index;
  final FakeCancelRideReason cancelReason;
  final FakeCancelRideReason selectedCancelReason;
  final int selectedPaymentOptionIndex;
  final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        hasShadow: hasShadow,
        paddingValue: const EdgeInsets.all(0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 62,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              border: Border.all(color: AppColors.primaryBorderColor)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                reasonName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
              AppGaps.wGap16,
              CustomRadioWidget(
                  value: index,
                  groupValue: selectedPaymentOptionIndex,
                  onChanged: radioOnChange),
            ],
          ),
        ));
  }
}

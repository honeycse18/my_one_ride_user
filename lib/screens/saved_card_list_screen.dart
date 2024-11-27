import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/saved_card_list_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class SavedcardListScreen extends StatelessWidget {
  const SavedcardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedCardListSCreenController>(
        global: false,
        init: SavedCardListSCreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: const Text('Credit Card')),
              body: ScaffoldBodyWidget(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saved Card',
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                  AppGaps.hGap16,
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return const AddCardWidget(
                          name: 'Michle Jhon Doe',
                          cardLast4Number: '2546',
                          cvc: 353,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap24,
                      itemCount: 5)
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    child: Text('Add New Card'),
                    onTap: () {},
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}

class AddCardWidget extends StatelessWidget {
  final String name;
  final String cardLast4Number;
  final int cvc;
  const AddCardWidget({
    super.key,
    required this.name,
    required this.cardLast4Number,
    required this.cvc,
  });

  @override
  Widget build(BuildContext context) {
    return PaymentCardWidget(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Name',
          style: AppTextStyles.bodyLargeMediumTextStyle
              .copyWith(color: Colors.white.withOpacity(0.8)),
        ),
        AppGaps.hGap4,
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleSemiSmallSemiboldTextStyle
              .copyWith(color: Colors.white),
        ),
        AppGaps.hGap16,
        Text(
          '**** **** **** $cardLast4Number',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleSemiSmallSemiboldTextStyle
              .copyWith(color: Colors.white),
        ),
        AppGaps.hGap26,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiration',
                    style: AppTextStyles.bodyLargeMediumTextStyle
                        .copyWith(color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    '02/11/21',
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CCV',
                    style: AppTextStyles.bodyLargeMediumTextStyle
                        .copyWith(color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    '$cvc',
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

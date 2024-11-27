import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/offer_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/offer_screen_widget.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferScreenController>(
        global: false,
        init: OfferScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                      AppLanguageTranslation.offerTransKey.toCurrentLanguage)),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) {
                      return OfferScreenWidget(
                        discount: 55,
                        onTap: () {},
                        // onTap:;
                      );
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                    itemCount: 25),
              ),
            ));
  }
}

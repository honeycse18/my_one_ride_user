import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/terms_condition_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsConditionScreenController>(
        global: false,
        init: TermsConditionScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xFFF7F7FB),

            /* <-------- Appbar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(controller.supportTextItem.title)),

            /* <-------- Content --------> */

            body: ScaffoldBodyWidget(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap10,
                    HtmlWidget(controller.supportTextItem.content),
                    AppGaps.hGap50,
                  ],
                ),
              ),
            )

            /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}

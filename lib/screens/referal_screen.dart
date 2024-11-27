import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/referal_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ReferalScreen extends StatelessWidget {
  const ReferalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferalScreenController>(
        global: false,
        init: ReferalScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, titleWidget: const Text('Referral')),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(children: [
                  AppGaps.hGap10,
                  const CustomTextFormField(
                    labelText: r'Refer a friend and Earn $20',
                    hintText: 'ksjfbjkasdgfhjgsdjh',
                    prefixIcon: AppGaps.wGap10,
                    suffixIcon:
                        SvgPictureAssetWidget(AppAssetImages.copySVGLogoLine),
                  ),
                  AppGaps.hGap32,
                  CustomStretchedTextButtonWidget(
                    buttonText: 'Invite',
                    onTap: () {},
                  )
                ]),
              )),
            ));
  }
}

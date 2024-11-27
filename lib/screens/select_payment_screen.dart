import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/select_payment_method_screen_controller.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/select_payment_method_widget.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPaymentScreenController>(
        global: false,
        init: SelectPaymentScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .selectPaymentTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  SliverList.separated(
                    itemCount: FakeData.paymentOptionList.length,
                    itemBuilder: (context, index) {
                      final paymentOption = FakeData.paymentOptionList[index];
                      return SelectPaymentMethodWidget(
                        paymentOptionImage: paymentOption.paymentImage,
                        cancelReason: paymentOption,
                        selectedCancelReason: controller.selectedPaymentOption,
                        paymentOption: paymentOption.viewAbleName,
                        hasShadow:
                            controller.selectedPaymentMethodIndex == index,
                        onTap: () {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        radioOnChange: (Value) {
                          controller.selectedPaymentMethodIndex = index;
                          controller.selectedPaymentOption = paymentOption;
                          controller.update();
                        },
                        index: index,
                        selectedPaymentOptionIndex:
                            controller.selectedPaymentMethodIndex,
                      );
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedButtonWidget(
                      onTap: controller.paymentAcceptCarRentRequest,
                      child: Text(
                          '${AppLanguageTranslation.paymentTransKey.toCurrentLanguage} => ${controller.postRentDetails.total}'),
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}

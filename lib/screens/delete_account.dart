import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/delete_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountScreenController>(
        init: DeleteAccountScreenController(),
        global: false,
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: const Text('Delete Account')),
              body: ScaffoldBodyWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap30,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .deleteAccountTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleSemiSmallBoldTextStyle
                                  .copyWith(color: Colors.black),
                            ),

                            AppGaps.hGap20,
                            Text(AppLanguageTranslation
                                .areYouWantDeleteAccountTransKey
                                .toCurrentLanguage), //Expanded(child: Text("Description")),
                            AppGaps.hGap20,
                            Text(
                              AppLanguageTranslation
                                  .accountTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleSemiSmallBoldTextStyle
                                  .copyWith(color: Colors.black),
                            ),
                            AppGaps.hGap20,
                            Text(
                              AppLanguageTranslation
                                  .deleteAccountRemoveDataTransKey
                                  .toCurrentLanguage,
                            ),
                            AppGaps.hGap30,
                            CustomStretchedButtonWidget(
                                onTap: controller.deleteUserAccount,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    AppGaps.wGap10,
                                    Text(
                                      AppLanguageTranslation
                                          .deleteTransKey.toCurrentLanguage,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/support_text_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class TermsConditionScreenController extends GetxController {
  SupportTextItem supportTextItem = SupportTextItem.empty();

  Future<void> getSupportText() async {
    SupportTextResponse? response =
        await APIRepo.getSupportText(slug: 'terms_&_condition');
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(SupportTextResponse response) {
    supportTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getSupportText();

    super.onInit();
  }
}

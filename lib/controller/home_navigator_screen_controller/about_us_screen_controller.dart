import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/about_us_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class AboutUsScreenController extends GetxController {
  // WebViewController webViewController = WebViewController();
  AboutUsData aboutUsTextItem = AboutUsData.empty();

  Future<void> getAboutusText() async {
    AboutUsResponse? response = await APIRepo.getAboutUsText();
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

  onSuccessRetrievingCategoriesList(AboutUsResponse response) {
    aboutUsTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getAboutusText();
    super.onInit();
  }
}

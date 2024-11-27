import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/driver_details_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class HireDriverDetailsScreenController extends GetxController {
  NearestDriverList hireDriver = NearestDriverList.empty();
  DriverDetailsData driverDetailsData = DriverDetailsData.empty();

  Future<void> getDriverDetails(String driverId) async {
    DriverDetailsResponse? response =
        await APIRepo.getDriverDetails(driverId: driverId);
    if (response == null) {
      Helper.showSnackBar(response?.msg ??
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingDriverDetails(response);
  }

  onSuccessRetrievingDriverDetails(DriverDetailsResponse response) {
    driverDetailsData = response.data;
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is NearestDriverList) {
      hireDriver = argument;
      if (hireDriver.id.isNotEmpty) {
        getDriverDetails(hireDriver.id);
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

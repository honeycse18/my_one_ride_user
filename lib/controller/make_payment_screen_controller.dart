import 'dart:developer';

import 'package:get/get.dart';

class MakePaymentScreenController extends GetxController {
  String test = 'Make payment screenController is connected!';

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      test = params;
      update();
      log(test);
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}

import 'package:get/get.dart';

class AddCardSCreenController extends GetxController {
  RxBool toggleHidePassword = true.obs;
  RxBool toggleSavedCard = true.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }
}

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class HomeScreenWidgetController extends GetxController {
  UserDetailsData userDetails = UserDetailsData.empty();

  void onLogOutButtonTap() {
    Helper.logout();
  }

  @override
  void onInit() {
    userDetails = Helper.getUser();
    super.onInit();
  }
}

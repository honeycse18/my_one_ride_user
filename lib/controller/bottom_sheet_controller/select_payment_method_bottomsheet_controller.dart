import 'package:get/get.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/models/fakeModel/payment_option_model.dart';

class SelectPaymentMethodBottomsheetController extends GetxController {
  int selectedReasonIndex = 0;

  SelectPaymentOptionModel paymentOptionList = SelectPaymentOptionModel();

  onSubmitButtonTap() {
    SelectPaymentOptionModel selectedOption =
        FakeData.paymentOptionList[selectedReasonIndex];

    Get.back(result: selectedOption);
  }
}

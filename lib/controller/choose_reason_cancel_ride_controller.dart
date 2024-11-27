import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/models/fakeModel/intro_content_model.dart';

class CancelReasonRideBottomSheetController extends GetxController {
  int selectedReasonIndex = -1;
  TextEditingController otherReasonTextController = TextEditingController();
  FakeCancelRideReason selectedCancelReason = FakeCancelRideReason();

  onSubmitButtonTap() {
    String reason = selectedCancelReason.reasonName == 'Other'
        ? otherReasonTextController.text
        : FakeData.cancelRideReason[selectedReasonIndex].reasonName;

    Get.back(result: reason);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/make_payment_screen_controller.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MakePaymentScreenController>(
        global: false,
        init: MakePaymentScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(controller.test),
            )));
  }
}

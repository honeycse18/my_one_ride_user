import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/favourit_list_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';

class FavouritListScreen extends StatelessWidget {
  const FavouritListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritListScreenController>(
        global: false,
        init: FavouritListScreenController(),
        builder: (controller) => const Scaffold(
              backgroundColor: AppColors.mainBg,
            ));
  }
}

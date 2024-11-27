import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/offer_ride_bottomsheet_parameters.dart';
import 'package:one_ride_user/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_user/models/screenParameters/share_ride_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/offer_ride_bottomsheet.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class RideShareScreenController extends GetxController {
  bool isFindSelected = true;

  LocationModel? pickUpLocation;
  LocationModel? dropLocation;
  String testString = 'Ride Share Screen!';
  int seatSelected = 0;

  var selectedStartDate = DateTime.now().obs;
  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndDate = DateTime.now().obs;
  var selectedEndTime = TimeOfDay.now().obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedStartDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedStartTime.value = newTime;
  }

  void updateSelectedEndDate(DateTime endDate) {
    selectedEndDate.value = endDate;
  }

  void updateSelectedEndTime(TimeOfDay endTime) {
    selectedEndTime.value = endTime;
  }

  void onPickUpTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: pickUpLocation, showCurrentLocationButton: true));
    if (result is LocationModel) {
      pickUpLocation = result;
      update();
    }
  }

  void onDropTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: dropLocation, showCurrentLocationButton: false));
    if (result is LocationModel) {
      dropLocation = result;
      update();
    }
  }

  void onFindPassengersButtonTap() {
    log('Find Passengers Button got tapped!');
    // DateTime combinedDateTime = DateTime.now();
    if (pickUpLocation != null && dropLocation != null && seatSelected != 0) {
      /* final Map<String, dynamic> parameters = {
        'lat': pickUpLocation!.latitude,
        'lng': pickUpLocation!.longitude,
        'seats': seatSelected,
        'date': Helper.yyyyMMddFormattedDateTime(combinedDateTime)
      }; */
      Get.toNamed(AppPageNames.chooseYouNeedScreen,
          arguments: ShareRideScreenParameter(
              pickUpLocation: pickUpLocation!,
              dropLocation: dropLocation ?? LocationModel.empty(),
              date: selectedStartDate.value,
              type: 'passenger',
              totalSeat: seatSelected));
    } else {
      APIHelper.onError(
          AppLanguageTranslation.mustFillLocationTransKey.toCurrentLanguage);
      return;
    }
  }

  void onFindCarButtonTap() {
    log('Find Car Button got tapped!');
    if (pickUpLocation != null && dropLocation != null && seatSelected != 0) {
      /* final Map<String, dynamic> parameters = {
        'lat': pickUpLocation!.latitude,
        'lng': pickUpLocation!.longitude,
        'seats': seatSelected,
        'date': Helper.yyyyMMddFormattedDateTime(combinedDateTime)
      }; */
      Get.toNamed(AppPageNames.chooseYouNeedScreen,
          arguments: ShareRideScreenParameter(
              pickUpLocation: pickUpLocation!,
              dropLocation: dropLocation ?? LocationModel.empty(),
              date: selectedStartDate.value,
              type: 'vehicle',
              totalSeat: seatSelected));
    } else {
      APIHelper.onError(
          AppLanguageTranslation.mustFillLocationTransKey.toCurrentLanguage);
      return;
    }
  }

  void onNextButtonTap() {
    if (pickUpLocation != null && dropLocation != null) {
      Get.bottomSheet(shareRideNextBottomSheet());
    } else {
      APIHelper.onError(
          AppLanguageTranslation.mustFillLocationTransKey.toCurrentLanguage);
      return;
    }
  }

  void onCreateRideButtonTap() {
    Get.bottomSheet(const OfferRideBottomSheet(),
        settings: RouteSettings(
            arguments: OfferRideBottomSheetParameters(
                pickUpLocation: pickUpLocation ?? LocationModel.empty(),
                dropLocation: dropLocation ?? LocationModel.empty(),
                isCreateOffer: true)));
  }

  void onOfferRideButtonTap() {
    Get.bottomSheet(const OfferRideBottomSheet(),
        settings: RouteSettings(
            arguments: OfferRideBottomSheetParameters(
                pickUpLocation: pickUpLocation ?? LocationModel.empty(),
                dropLocation: dropLocation ?? LocationModel.empty(),
                isCreateOffer: false)));
  }

  Widget shareRideTabWidget(
      {String title = 'Title', bool isSelected = false, Function()? onTap}) {
    // final String title;
    // final bool isSelected;
    // final Function()? onTap;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: isSelected ? Colors.white : AppColors.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget shareRideNextBottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: AppColors.shadeColor2,
      ),
      height: 238,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TightIconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 25,
                        offset: const Offset(0, 14))
                  ]),
              child: const Center(
                  child: SvgPictureAssetWidget(
                AppAssetImages.arrowLeftSVGLogoLine,
                color: AppColors.darkColor,
              )),
            ),
          ),
          AppGaps.hGap24,
          Text(
            AppLanguageTranslation.whatYouWantTransKey.toCurrentLanguage,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor),
          ),
          AppGaps.hGap16,
          Row(
            children: [
              Expanded(
                  child: CustomStretchedOutlinedButtonWidget(
                onTap: onCreateRideButtonTap,
                child: Text(
                  AppLanguageTranslation.createRideTransKey.toCurrentLanguage,
                ),
              )),
              AppGaps.wGap16,
              Expanded(
                  child: StretchedTextButtonWidget(
                      onTap: onOfferRideButtonTap,
                      buttonText: AppLanguageTranslation
                          .offerARideTransKey.toCurrentLanguage))
            ],
          )
        ],
      ),
    );
  }
}

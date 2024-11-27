import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/country_list_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/select_screen_parameters.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class MyAccountScreenController extends GetxController {
  UserDetailsCountry? selectedCountry;
  List<UserDetailsCountry> countryList = [];
  bool editActive = false;

  bool imageEdit = false;
  bool nameEdit = false;
  bool emailEdit = false;
  bool phoneEdit = false;
  bool dialEdit = false;
  bool genderEdit = false;
  bool addressEdit = false;
  bool countryEdit = false;

  List<Uint8List> selectedProfileImages = [];
  Uint8List selectedProfileImage = Uint8List(0);

  bool emailVerified = false;
  bool phoneVerified = true;
  UserDetailsData userDetails = UserDetailsData.empty();
  String dialCode = '';
  String phoneNumber = '';
  String selectedGender = 'Male';
  LocationModel? selectedLocation;
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  // final RxBool isDropdownOpen = false.obs;
  // final RxString selectedGender = 'Select Gender'.obs;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

  void onCountryChange(CountryCode countryCode) {
    // currentCountryCode = countryCode;
    // update();
    // if (currentCountryCode.dialCode == dialCode) {
    //   dialEdit = false;
    // } else {
    //   dialEdit = true;
    // }
    // update();
    // editable();
  }

  Widget countryElementsList(UserDetailsCountry country) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            country.code,
            height: 60,
            width: 60,
            borderRadius: 15,
          ),
          AppGaps.wGap15,
          Expanded(
              child: Text(
            country.name,
            style: AppTextStyles.bodyBoldTextStyle,
          ))
        ],
      ),
    );
  }

  Future<void> getCountryElementsRide() async {
    CountryListResponse? response = await APIRepo.getCountryList();
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(CountryListResponse response) {
    countryList = response.data;
    update();
  }

  void onAddressTap() async {
    if (imageEditCheck()) {
      return;
    }
    dynamic result = await Get.toNamed(AppPageNames.selectLocation,
        arguments: SelectLocationScreenParameters(
            screenTitle:
                AppLanguageTranslation.selectAddressTransKey.toCurrentLanguage,
            showCurrentLocationButton: true,
            locationModel: selectedLocation));
    if (result is LocationModel) {
      addressTextEditingController.text = result.address;
      selectedLocation = result;
      update();
      log('Address: ${result.address}');
    }
  }

  onEditImageButtonTap() {
    if (fieldEditCheck()) {
      return;
    }
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingProfileImage,
        imageName: 'Profile Image');
  }

  void _onSuccessUploadingProfileImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedProfileImages.clear();
    selectedProfileImages.addAll(rawImagesData);
    update();
    if (selectedProfileImages.isEmpty) {
      imageEdit = false;
    } else {
      imageEdit = true;
      selectedProfileImage = selectedProfileImages.firstOrNull ?? Uint8List(0);
    }
    update();
    editable();
    Helper.showSnackBar(AppLanguageTranslation
        .uploadPictureSuccessfullyTransKey.toCurrentLanguage);
  }

  onSaveChangesButtonTap() {
    log('Save Changes button got tapped!');
    updateProfile();
  }

  Future<void> updateProfile() async {
    final selectedProfileImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedProfileImage);

    final FormData requestBody = FormData({});
    final Map<String, dynamic> requestBodyJson = {};
    RawAPIResponse? response;

    if (imageEdit) {
      requestBody.files.add(MapEntry(
          'image',
          MultipartFile(selectedProfileImageConvertedToByte,
              filename: 'profile_image.jpg', contentType: 'image/jpeg')));
    }
    if (addressEdit) {
      final Map<String, dynamic> location = {
        'lat': selectedLocation?.latitude ?? 0,
        'lng': selectedLocation?.longitude ?? 0
      };
      requestBodyJson['address'] = selectedLocation?.address ?? '';
      requestBodyJson['location'] = location;
    }
    if (nameEdit) {
      requestBodyJson['name'] = nameTextEditingController.text;
    }
    if (countryEdit) {
      requestBodyJson['country'] = selectedCountry?.id ?? '';
    }
    String requestBodyString = jsonEncode(requestBodyJson);
    if (imageEdit) {
      response = await APIRepo.updateUserProfile(requestBody);
    } else {
      response = await APIRepo.updateUserProfile(requestBodyString);
    }
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseUploadPictureSuccessfullyTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessUpdatingProfile(response);
  }

  onSuccessUpdatingProfile(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    setUpdatedUserDetailsToLocalStorage();
  }

  Future<void> setUpdatedUserDetailsToLocalStorage() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    getUser();
    selectedProfileImage = Uint8List(0);
    selectedProfileImages.clear();

    imageEdit = false;
    nameEdit = false;
    emailEdit = false;
    phoneEdit = false;
    dialEdit = false;
    genderEdit = false;
    addressEdit = false;
    countryEdit = false;
    editable();
    update();
  }

  void onGenderChange(String? selectedItem) {
    selectedGender = selectedItem ?? 'Male';
    genderEdit = selectedGender.isNotEmpty;
    update();
    editable();
  }
/* 
  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectGender(String gender) {
    selectedGender = gender;
    isDropdownOpen = false;
  } */

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  void getUser() {
    userDetails = Helper.getUser();
    final phoneNumberParts = Helper.separatePhoneAndDialCode(userDetails.phone);
    dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    LocationModel prevLocation = LocationModel(
        latitude: userDetails.location.lat,
        longitude: userDetails.location.lng,
        address: userDetails.address);
    selectedLocation = prevLocation;
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    selectedCountry = countryList
        .firstWhereOrNull((element) => element.id == userDetails.country.id);

    update();
  }

  bool imageEditCheck() {
    bool ret = false;
    if (imageEdit) {
      AppDialogs.showConfirmDialog(
        shouldCloseDialogOnceYesTapped: true,
        messageText: AppLanguageTranslation
            .confirmUploadProfileImageTransKey.toCurrentLanguage,
        onYesTap: () async {
          selectedProfileImage = Uint8List(0);
          imageEdit = false;
          editable();
          ret = false;
          update();
        },
      );
      if (imageEdit) {
        ret = true;
      }
    }
    return ret;
  }

  bool fieldEditCheck() {
    bool ret = false;
    if (nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit ||
        countryEdit) {
      AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .confirmUploadProfileImageTransKey.toCurrentLanguage,
        onYesTap: () async {
          nameTextEditingController.text = '';
          emailTextEditingController.text = '';
          phoneTextEditingController.text = '';
          addressTextEditingController.text = '';
          selectedCountry = countryList.firstWhereOrNull(
              (element) => element.id == userDetails.country.id);
          nameEdit = false;
          emailEdit = false;
          phoneEdit = false;
          dialEdit = false;
          genderEdit = false;
          addressEdit = false;
          countryEdit = false;
          ret = false;
          update();
          editable();
        },
      );
      if (nameEdit ||
          emailEdit ||
          phoneEdit ||
          dialEdit ||
          genderEdit ||
          addressEdit ||
          countryEdit) {
        ret = true;
      }
    }
    return ret;
  }

  editable() {
    if (imageEdit ||
        nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit ||
        countryEdit) {
      editActive = true;
    } else {
      editActive = false;
    }
    update();
  }

  @override
  void onInit() async {
    await getCountryElementsRide();
    getUser();
    nameTextEditingController.addListener(() {
      imageEditCheck();
      if (nameTextEditingController.text.isNotEmpty &&
          nameTextEditingController.text != userDetails.name) {
        nameEdit = true;
      } else {
        nameEdit = false;
      }
      update();
      editable();
    });
    /* emailTextEditingController.addListener(() {
      if (emailTextEditingController.text.isNotEmpty &&
          emailTextEditingController.text != userDetails.email) {
        emailEdit = true;
      } else {
        emailEdit = false;
      }
      update();
      editable();
    });
    phoneTextEditingController.addListener(() {
      if (phoneTextEditingController.text.isNotEmpty &&
          getPhoneFormatted() != userDetails.phone) {
        phoneEdit = true;
      } else {
        phoneEdit = false;
      }
      update();
      editable();
    }); */
    addressTextEditingController.addListener(() {
      imageEditCheck();
      if (addressTextEditingController.text.isNotEmpty &&
          addressTextEditingController.text != userDetails.address) {
        addressEdit = true;
      } else {
        addressEdit = false;
      }
      update();
      editable();
    });
    super.onInit();
  }
}

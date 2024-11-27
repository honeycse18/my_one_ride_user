import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:in_app_update/in_app_update.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:intl/intl.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/constants/app_local_stored_keys.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/image_picker_helper.dart';
import 'package:one_ride_user/widgets/dialogs.dart';
import 'package:path_provider/path_provider.dart';

/// This file contains helper functions and properties
class Helper {
  // static void select1ItemFromList(
  //     int listLength, int selectionIndex, Function(int, bool) doSelectOnIndex) {
  //   List.generate(listLength,
  //           (int booleanDataIndex) => booleanDataIndex == selectionIndex)
  //       .forEachIndexed((int dataIndex, bool booleanData) =>
  //           doSelectOnIndex(dataIndex, booleanData));
  // }

  static Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  // static NumberFormat get _currentNumberFormat {
  //   try {
  //     return NumberFormat.currency(
  //         locale: Constants.fallbackFrenchLocale,
  //         symbol: AppSingleton.instance.settings.currencySymbol);
  //   } catch (e) {
  //     return NumberFormat.currency(
  //         locale: Constants.fallbackLocale,
  //         symbol: AppSingleton.instance.settings.currencySymbol);
  //   }
  // }

  /// Return default currency formatted text as string. Example: 45000 will
  /// return as $45,000
  // static String getCurrencyFormattedAmountText(double amount) {
  //   return _currentNumberFormat.format(amount);
  // }

  static String getFirstSafeString(List<String> images) {
    return images.firstOrNull ?? '';
  }

  static double getAvailableScreenHeightForBottomSheet(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    final double topUnavailableSpaceValue = MediaQuery.of(context).padding.top;
    final double topAvailableSpaceValue =
        screenSize.height - topUnavailableSpaceValue;
    return topAvailableSpaceValue;
  }

  static String getUserToken() {
    dynamic userToken = GetStorage().read(LocalStoredKeyName.loggedInUserToken);
    if (userToken is! String) {
      return '';
    }
    return userToken;
  }

  static hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  static String getRelativeDateTimeText(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inDays == 1
        ? 'Yesterday'
        : timeago.format(dateTime);
  }

  static Future<void> setLoggedInUserToLocalStorage(
      UserDetailsData userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String userDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage().write(LocalStoredKeyName.loggedInUser, userDetailsJson);
  }

  static UserDetailsData getUser() {
    dynamic loggedInUserJsonString =
        GetStorage().read(LocalStoredKeyName.loggedInUser);
    if (loggedInUserJsonString is! String) {
      return UserDetailsData.empty();
    }
    dynamic loggedInUserJson = jsonDecode(loggedInUserJsonString);
/*     if (loggedInUserJson is! Map<String, dynamic>) {
      return UserDetails.empty();
    } */
    return UserDetailsData.getAPIResponseObjectSafeValue(loggedInUserJson);
  }

  static void logout() async {
    GetStorage().write(LocalStoredKeyName.loggedInUserToken, null);
    GetStorage().write(LocalStoredKeyName.loggedInUser, null);
    await AppSingleton.instance.localBox.clear();

    Get.offAllNamed(AppPageNames.introScreen);
  }

  static String getUserBearerToken() {
    String loggedInUserToken = getUserToken();
    return 'Bearer $loggedInUserToken';
  }

  static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty /* || (!getUser().isEmpty()) */);
  }
  /* static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty || (!getUser().isEmpty()));
  } */

  static void showTopSnackbar(
      {required String message, Widget? actionWidget, Widget? leftsideWidget}) {
    final context = Get.context;
    if (context == null) {
      return;
    }
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      titleText: Row(
        children: [
          if (leftsideWidget != null) leftsideWidget,
          if (leftsideWidget != null) AppGaps.wGap8,
          Expanded(
            child: Text(message,
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
      messageText: AppGaps.emptyGap,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      backgroundColor: AppColors.alertLightColor,
      mainButton: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: actionWidget,
      ),
    ).show(context);
  }

  static void showTopSnackbarWithMessage(String message,
      {void Function()? onActionButtonTap}) {
    HapticFeedback.lightImpact(); // Trigger haptic feedback
    Helper.showTopSnackbar(
      message: message,
      actionWidget: TightTextButtonWidget(
        text: 'Login',
        textStyle:
            AppTextStyles.bodySemiboldTextStyle.copyWith(color: Colors.white),
        onTap: () {
          if (onActionButtonTap != null) {
            onActionButtonTap();
          }
        },
      ),
    );
  }

  static bool isRememberedMe() {
    final dynamic isRememberedMe =
        GetStorage().read(LocalStoredKeyName.rememberMe);
    if (isRememberedMe is bool) {
      return isRememberedMe;
    }
    return false;
  }

/*   static String? passwordFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return 'Password can not be empty';
      }
      if (text.length < 6) {
        return 'Minimum length 6';
      }
      if (!text.contains(RegExp(r'[0-9]'))) {
        return 'Must contain a digit';
      }
    }
    return null;
  } */

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> getGPSLocationData() async {
    try {
      // Test if location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        AppDialogs.showErrorDialog(
            messageText: 'Location services are disabled. Please turn on GPS');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          AppDialogs.showErrorDialog(
              messageText:
                  'Location permissions are denied. Please try again to permit location access');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        AppDialogs.showErrorDialog(
            messageText:
                'Location permissions are permanently denied, we cannot request permissions. You can permit location by going on app settings.');
        return null;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return null;
    }
  }

  static String getRoundedDecimalUpToTwoDigitText(double doubleNumber) {
    return doubleNumber.toStringAsFixed(2);
  }

  /// Generate Material color
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _generateTintColor(color, 0.9),
      100: _generateTintColor(color, 0.8),
      200: _generateTintColor(color, 0.6),
      300: _generateTintColor(color, 0.4),
      400: _generateTintColor(color, 0.2),
      500: color,
      600: _generateShadeColor(color, 0.1),
      700: _generateShadeColor(color, 0.2),
      800: _generateShadeColor(color, 0.3),
      900: _generateShadeColor(color, 0.4),
    });
  }

  // Helper functions for above function
  static int _generateTintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
      _generateTintValue(color.red, factor),
      _generateTintValue(color.green, factor),
      _generateTintValue(color.blue, factor),
      1);

  static int _generateShadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color _generateShadeColor(Color color, double factor) =>
      Color.fromRGBO(
          _generateShadeValue(color.red, factor),
          _generateShadeValue(color.green, factor),
          _generateShadeValue(color.blue, factor),
          1);

  static void showSnackBar(String message) {
    BuildContext? context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // static Future<Placemark?> getAddressDetails(
  //     double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latitude, longitude);
  //     return placemarks.firstOrNull;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static String getAddressDetailsText(Placemark placemark) {
  //   String addressText = '';
  //   if (placemark.name != null && (placemark.name?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.name}, ';
  //   }
  //   if (placemark.subLocality != null &&
  //       (placemark.subLocality?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.subLocality}, ';
  //   }
  //   if (placemark.administrativeArea != null &&
  //       (placemark.administrativeArea?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.administrativeArea}, ';
  //   }
  //   if (placemark.postalCode != null &&
  //       (placemark.postalCode?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.postalCode}, ';
  //   }
  //   if (placemark.country != null && (placemark.country?.isNotEmpty ?? false)) {
  //     addressText += '${placemark.country}';
  //   }
  //   return addressText;
  // }

  static Color getColor(String hexCode) {
    final hexColor = hexCode.replaceFirst('#', '');
    return Color((int.tryParse(hexColor, radix: 16) ?? 0) + 0xFF000000);
  }

  static String formatTransactionName(String text) {
    // Replace underscores with spaces
    String spacedText = text.replaceAll('_', ' ');

    // Capitalize the first character of each word
    List<String> words = spacedText.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    // Join the words back together
    return words.join(' ');
  }

  static String ddMMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy').format(dateTime);
  static String yyyyMMddFormattedDateTime(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);
  static String ddMMMyyyyhhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, hh:mm a').format(dateTime);
  static String ddMMMyyyyhhmmaFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM,yyyy | hh:mm a').format(dateTime);

  static String hhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);
  static int dateTimeDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime.now())
        .inDays;
  }

  static String timeZoneSuffixedDateTimeFormat(DateTime dateTime) {
    // Creating a DateFormat object with the required format
    DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");

    // Formatting the DateTime object using the formatter
    String formattedDateTime = formatter.format(dateTime);

    // Calculating the timezone offset
    Duration offset = dateTime.timeZoneOffset;
    String offsetSign = offset.isNegative ? '-' : '+';
    String offsetHours = offset.inHours.abs().toString().padLeft(2, '0');
    String offsetMinutes =
        offset.inMinutes.abs().remainder(60).toString().padLeft(2, '0');

    // Constructing the final formatted date string with timezone offset
    String finalFormattedDateTime =
        '$formattedDateTime$offsetSign$offsetHours$offsetMinutes';

    return finalFormattedDateTime;
  }

  static void checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        print('Update available');
        showUpdateDialog();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static void showUpdateDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Update Available"),
        content: Text(
            "A new version of the app is available. Would you like to update now?"),
        actions: <Widget>[
          TextButton(
            child: Text("Later"),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text("Update"),
            onPressed: () {
              Get.back();
              autoUpdate();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void autoUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      print(e.toString());
    }
  }

  static String ddMMMFormattedDate(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);
  static String hhmmFormattedTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  /// Returns if today, true
  static bool isToday(DateTime date) {
    return dateTimeDifferenceInDays(date) == 0;
  }

  /// Returns if tomorrow, true
  static bool isTomorrow(DateTime date) {
    return dateTimeDifferenceInDays(date) == 1;
  }

  /// Returns if yesterday, true
  static bool wasYesterday(DateTime date) {
    return dateTimeDifferenceInDays(date) == -1;
  }

  static int getRandom6DigitGeneratedNumber() {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    double next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  // sta
  static void pickImages(
      {String imageName = '',
      required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final List<image_picker.XFile>? pickedImages =
        await ImagePickerHelper.getPhoneImages();
    if (pickedImages == null || pickedImages.isEmpty) {
      return;
    }
    processPickedImages(pickedImages,
        onSuccessUploadSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static void processPickedImages(List<image_picker.XFile> pickedImages,
      {required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    List<Uint8List>? processedImages =
        await ImagePickerHelper.getProcessedImages(pickedImages);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    /* if (processedImages == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    } */
    final String messageText = imageName.isEmpty
        ? 'Are you sure to set this image?'
        : 'Are you sure to set this image as $imageName?';
    Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    );
    if (confirmResponse is bool && confirmResponse) {
      onSuccessUploadSingleImage(processedImages, additionalData);
      // String imageFileName = '';
      // String id = '';
/*       Uri? logoUri = Uri.tryParse(vendorDetails.store.nidImage);
      if (logoUri != null) {
        if (logoUri.pathSegments.length >= 2) {
          // id = logoUri.pathSegments[logoUri.pathSegments.length - 2];
          // imageFileName = logoUri.pathSegments[logoUri.pathSegments.length - 1];
        }
      } */
      /* APIHelper.uploadSingleImage(processedImage, onSuccessUploadSingleImage,
          imageFileName: imageFileName,
          id: id,
          additionalData: additionalData,
          token: token); */
    }
  }

  static Future<File> getTempFileFromImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${getRandom6DigitGeneratedNumber()}.jpg')
            .create();
    return file.writeAsBytes(imageBytes);
  }

  static String getCurrencyFormattedWithDecimalAmountText(double amount,
      [int decimalDigit = 2]) {
    return AppComponents.defaultDecimalNumberFormat.format(amount);
  }

  static void scrollToStart(ScrollController scrollController) {
    if (scrollController.hasClients && !scrollController.position.outOfRange) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  static String ddMMyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd/MM/yy').format(dateTime);

  static String ddMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yyyy').format(dateTime);

  static String hhMMaFormattedDate(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  static String dayFullFormattedDateTime(DateTime dateTime) =>
      DateFormat('EEEE').format(dateTime);

  static String hhmm24FormattedDateTime(TimeOfDay dateTime) =>
      DateFormat('hh:mm').format(
          DateTime(DateTime.now().year, 1, 0, dateTime.hour, dateTime.minute));

  static String avatar2LetterUsername(String firstName, String lastName) {
    if (lastName.isEmpty) {
      if (firstName.isEmpty) {
        return '';
      }
      final firstCharacter = firstName.characters.first;
      final secondCharacter = firstName.characters.length >= 2
          ? firstName.characters.elementAt(1)
          : '';
      return '$firstCharacter$secondCharacter';
    }
    if (firstName.isEmpty) {
      return '';
    }
    final firstCharacter = firstName.characters.first;
    final secondCharacter = lastName.characters.first;
    return '$firstCharacter$secondCharacter';
  }

  static ({String dialCode, String strippedPhoneNumber})?
      separatePhoneAndDialCode(String fullPhoneNumber) {
    final foundCountryCode = codes.firstWhereOrNull(
        (code) => fullPhoneNumber.contains(code['dial_code'] ?? ''));
    if (foundCountryCode == null) {
      return null;
    }
    var dialCode = fullPhoneNumber.substring(
      0,
      foundCountryCode["dial_code"]!.length,
    );
    var newPhoneNumber = fullPhoneNumber.substring(
      foundCountryCode["dial_code"]!.length,
    );
    return (dialCode: dialCode, strippedPhoneNumber: newPhoneNumber);
  }

  static String? phoneFormValidator(String? text) {
    if (text != null) {
      if (text.length < 6) {
        return 'Invalid phone number format';
      }
      return null;
    }
    return null;
  }
/*   static String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return 'Invalid phone number format';
      }
      return null;
    }
    return null;
  } */

  static String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return 'Invalid email format';
      }
      return null;
    }
    return null;
  }

  static String? passwordFormValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(text)) {
      return 'Password must include at least 1 uppercase letter';
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(text)) {
      return 'Password must include at least 1 lowercase letter';
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(text)) {
      return 'Password must include at least 1 number';
    } else if (!RegExp(r'(?=.*?[!@#$%^&*])').hasMatch(text)) {
      return 'Password must include at least 1 special character (!@#\$%^&*)';
    } else if (text.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? loginPasswordFormValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  /// used to check User name Input Field Should no empty
  static String? textFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (text.length < 3) return 'Minimum length 3';
    }
    return null;
  }

  static String? withdrawValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (double.tryParse(text) == 0 || double.parse(text) < 0) {
        return 'Amount must be greater than 0';
      }
    }
    return null;
  }
}

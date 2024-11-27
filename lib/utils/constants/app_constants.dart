import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/utils/constants/app_secrets.dart';

/// This is a Barrel file containing custom configurations of this app. Import
/// this one file to import all the files from below.
export 'app_colors.dart';
export 'app_components.dart';
export 'app_gaps.dart';
export 'app_images.dart';

class AppConstants {
  // static const String appLiveBaseURL = 'https://backend.1rides.com';
  static const String appLiveBaseURL = 'https://1ridebackend.appstick.com.bd';
  static const String appLocalhostBaseURL = 'http://192.168.0.160:4200';
  static const bool isTestOnLocalhost = false;
  static const String appBaseURL =
      isTestOnLocalhost ? appLocalhostBaseURL : appLiveBaseURL;
  static const String googleMapBaseURL = 'https://maps.googleapis.com';

  static const String apiContentTypeFormURLEncoded =
      'application/x-www-form-urlencoded';
  static const String apiContentTypeJSON = 'application/json';
  static const String googleAPIKey = AppSecrets.googleAPIKey;

  // Push Notification configs
  static const String notificationChannelID = 'oneride';
  static const String notificationChannelName = 'One Ride';
  static const String notificationChannelDescription =
      'One Ride app notification channel';
  static const String notificationChannelTicker = 'onerideticker';

  static const int defaultUnsetDateTimeYear = 1800;

  static const String apiDateTimeFormatValue =
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

  static const double dialogBorderRadiusValue = 20;
  static const String apiOnlyDateFormatValue = 'dd-MM-yyyy';
  static const String apiOnlyTimeFormatValue = 'HH:mm';
  //----------------------
  static const String hireDriverStatusHourly = 'hourly';
  static const String hireDriverStatusFixed = 'fixed';
  //----------------------
  static const String rentCarStatusHourly = 'hourly';
  static const String rentCarStatusWeekly = 'weekly';
  static const String rentCarStatusMonthly = 'monthly';
  // Vehicle Info Type status
  static const String vehicleDetailsInfoTypeStatusSpecifications =
      'specifications';
  static const String vehicleDetailsInfoTypeStatusFeatures = 'features';
  static const String vehicleDetailsInfoTypeStatusReview = 'review';

  // Dialog padding values
  static const double dialogVerticalSpaceValue = 16;
  static const double dialogHalfVerticalSpaceValue = 8;
  static const double dialogHorizontalSpaceValue = 18;
  static const double imageBorderRadiusValue = 14;
  static const double smallBorderRadiusValue = 5;
  static const double auctionGridItemBorderRadiusValue = 20;
  static const double uploadImageButtonBorderRadiusValue = 12;
  static const double defaultBorderRadiusValue = 18;
  static const String userRoleUser = 'user';
  // static const LatLng defaultMapLatLng = LatLng(8.662471152081386,
  //     1.0180393971192057); // Coordinate of Togo country center
  static const LatLng defaultMapLatLng =
      LatLng(0.0, 0.0); // Coordinate of Khulna
  static const double unknownLatLongValue = -999;
  static const CameraPosition defaultMapCameraPosition = CameraPosition(
    target: defaultMapLatLng,
    zoom: defaultMapZoomLevel,
  );

  // messege status
  static const String messageTypeStatusUser = 'user';
  static const String messageTypeStatusOwner = 'owner';
  static const String messageTypeStatusDriver = 'driver';
  static const String messageTypeStatusAdmin = 'admin';

  static const double defaultMapZoomLevel = 12.4746;
  static const double borderRadiusValue = 28;

  static const String cardStatus = 'card';
  static const String bankStatus = 'bank';
  static const String paypalStatus = 'paypal';

  static const String orderStatusPending = 'pending';
  static const String orderStatusAccepted = 'accepted';
  static const String orderStatusRejected = 'rejected';
  static const String orderStatusPicked = 'picked';
  static const String orderStatusOnWay = 'on_way';
  static const String orderStatusDelivered = 'delivered';

  static const String paymentMethodCashOnDelivery = 'cash_on_delivery';

  static const String confirmedOrderNotifyTypeConfirmOrder =
      'confirm_order_notify';

  static const String rideRequestAccepted = 'accepted';
  static const String rideRequestRejected = 'rejected';

  static const String paymentMethodWallet = 'wallet';
  static const String paymentMethodCash = 'cash';
  static const String paymentMethodPaypal = 'paypal';
  static const String paymentMethodStripe = 'stripe';

  static const String ridePostAcceptanceFindRide = 'find_ride';
  static const String ridePostAcceptanceOfferRide = 'offer_ride';
  static const String ridePostAcceptanceStarted = 'started';
  static const String ridePostAcceptanceCompleted = 'completed';
  static const String ridePostAcceptanceCancelled = 'cancelled';

  static const String shareRideActionMyRequest = 'request';
  static const String shareRideActionMyOffer = 'offer';

  // All types of statuses

  static const String shareRideAllStatusActive = 'active';
  static const String shareRideAllStatusAccepted = 'accepted';
  static const String shareRideAllStatusRejected = 'reject';
  static const String shareRideAllStatusStarted = 'started';
  static const String shareRideAllStatusPending = 'pending';
  static const String shareRideAllStatusCompleted = 'completed';
  static const String shareRideAllStatusCancelled = 'cancelled';
  static const String shareRideAllStatusOffer = 'offer';
  static const String shareRideAllStatusRequest = 'request';
  static const String shareRideAllStatusVehicle = 'vehicle';
  static const String shareRideAllStatusPassenger = 'passenger';

  static const String unknown = 'unknown';

  static const String hiveBoxName = 'one_ride';
  static const String hiveDefaultLanguageKey = 'default_language';
  static const String languageTranslationKeyCode = '_code';
  static const String fallbackEnglishLocale = 'en_US';
  static const String fallbackFrenchLocale = 'fr_FR';

  //Hire Driver list Type
  static const String hireDriverListEnumAccept = 'accepted';
  static const String hireDriverListEnumStarted = 'started';
  static const String hireDriverListEnumUserPending = 'user_pending';
  static const String hireDriverListEnumDriverPending = 'driver_pending';
  static const String hireDriverListEnumComplete = 'completed';
  static const String hireDriverListEnumCancel = 'cancelled';

  /// Screen horizontal padding value
  static const double screenPaddingValue = 24;
  // Methods
  static BorderRadius borderRadius(double radiusValue) =>
      BorderRadius.all(Radius.circular(radiusValue));
}

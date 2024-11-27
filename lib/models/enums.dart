import 'package:one_ride_user/utils/constants/app_constants.dart';

enum MyOrderTabState { pending, delivered, cancelled }
/* <-------- Enums for various screens --------> */

enum ResetPasswordSelectedChoice {
  none,
  mail,
  phoneNumber,
}

enum PasswordStrongLevel {
  none,
  error,
  weak,
  normal,
  strong,
  veryStrong,
}

enum LanguageSetting { english, russian, french, canada, australian, german }

enum CountrySetting { usa, russian, french, canada, australian, german }

enum CurrencySetting { usa, russian, bdt, canada, australian, german }

enum HomeScreenStatus { offline, online, orderList, currentOrderDetails }

enum OrderStatus {
  pending(AppConstants.orderStatusPending, 'Pending'),
  accepted(AppConstants.orderStatusAccepted, 'Accepted'),
  rejected(AppConstants.orderStatusRejected, 'Rejected'),
  picked(AppConstants.orderStatusPicked, 'Picked'),
  onWay(AppConstants.orderStatusOnWay, 'On the way'),
  delivered(AppConstants.orderStatusDelivered, 'Delivered'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const OrderStatus(this.stringValue, this.viewableText);

  static OrderStatus toEnumValue(String value) {
    final Map<String, OrderStatus> stringToEnumMap = {
      OrderStatus.pending.stringValue: OrderStatus.pending,
      OrderStatus.accepted.stringValue: OrderStatus.accepted,
      OrderStatus.rejected.stringValue: OrderStatus.rejected,
      OrderStatus.picked.stringValue: OrderStatus.picked,
      OrderStatus.onWay.stringValue: OrderStatus.onWay,
      OrderStatus.delivered.stringValue: OrderStatus.delivered,
      OrderStatus.unknown.stringValue: OrderStatus.unknown,
    };
    return stringToEnumMap[value] ?? OrderStatus.unknown;
  }
}

enum ConfirmedOrderNotificationType {
  confirmOrder(AppConstants.confirmedOrderNotifyTypeConfirmOrder),
  unknown(AppConstants.unknown);

  final String stringValue;
  const ConfirmedOrderNotificationType(this.stringValue);

  static ConfirmedOrderNotificationType toEnumValue(String value) {
    final Map<String, ConfirmedOrderNotificationType> stringToEnumMap = {
      ConfirmedOrderNotificationType.confirmOrder.stringValue:
          ConfirmedOrderNotificationType.confirmOrder,
      ConfirmedOrderNotificationType.unknown.stringValue:
          ConfirmedOrderNotificationType.unknown,
    };
    return stringToEnumMap[value] ?? ConfirmedOrderNotificationType.unknown;
  }
}

enum PaymentMethodName {
  cashOnDelivery(AppConstants.paymentMethodCashOnDelivery, 'Cash on delivery'),
  stripe(AppConstants.paymentMethodStripe, 'Stripe'),
  paypal(AppConstants.paymentMethodPaypal, 'Paypal'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String viewableText;
  const PaymentMethodName(this.stringValue, this.viewableText);

  static PaymentMethodName toEnumValue(String value) {
    final Map<String, PaymentMethodName> stringToEnumMap = {
      PaymentMethodName.cashOnDelivery.stringValue:
          PaymentMethodName.cashOnDelivery,
      PaymentMethodName.stripe.stringValue: PaymentMethodName.stripe,
      PaymentMethodName.paypal.stringValue: PaymentMethodName.paypal,
      PaymentMethodName.unknown.stringValue: PaymentMethodName.unknown,
    };
    return stringToEnumMap[value] ?? PaymentMethodName.unknown;
  }
}

enum RideRequestStatus {
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  rejected(AppConstants.rideRequestRejected, 'Rejected'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideRequestStatus(this.stringValue, this.stringValueForView);

  static RideRequestStatus toEnumValue(String value) {
    final Map<String, RideRequestStatus> stringToEnumMap = {
      RideRequestStatus.accepted.stringValue: RideRequestStatus.accepted,
      RideRequestStatus.rejected.stringValue: RideRequestStatus.rejected,
      RideRequestStatus.unknown.stringValue: RideRequestStatus.unknown,
    };
    return stringToEnumMap[value] ?? RideRequestStatus.unknown;
  }
}

enum PaymentMethodItems {
  wallet(AppConstants.paymentMethodWallet, 'Wallet'),
  cash(AppConstants.paymentMethodCash, 'Cash'),
  paypal(AppConstants.paymentMethodPaypal, 'Paypal'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const PaymentMethodItems(this.stringValue, this.stringValueForView);

  static PaymentMethodItems toEnumValue(String value) {
    final Map<String, PaymentMethodItems> stringToEnumMap = {
      PaymentMethodItems.wallet.stringValue: PaymentMethodItems.wallet,
      PaymentMethodItems.cash.stringValue: PaymentMethodItems.cash,
      PaymentMethodItems.paypal.stringValue: PaymentMethodItems.paypal,
      PaymentMethodItems.unknown.stringValue: PaymentMethodItems.unknown,
    };
    return stringToEnumMap[value] ?? PaymentMethodItems.unknown;
  }
}

enum RideHistoryStatus {
  pending(AppConstants.orderStatusPending, 'Pending'),
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideHistoryStatus(this.stringValue, this.stringValueForView);

  static RideHistoryStatus toEnumValue(String value) {
    final Map<String, RideHistoryStatus> stringToEnumMap = {
      RideHistoryStatus.pending.stringValue: RideHistoryStatus.pending,
      RideHistoryStatus.accepted.stringValue: RideHistoryStatus.accepted,
      RideHistoryStatus.started.stringValue: RideHistoryStatus.started,
      RideHistoryStatus.completed.stringValue: RideHistoryStatus.completed,
      RideHistoryStatus.cancelled.stringValue: RideHistoryStatus.cancelled,
      RideHistoryStatus.unknown.stringValue: RideHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? RideHistoryStatus.unknown;
  }
}

//Payment method object

enum PaymentHistoryStatus {
  card(AppConstants.cardStatus, 'Card'),
  bank(AppConstants.bankStatus, 'Bank'),
  paypal(AppConstants.paypalStatus, 'Paypal'),

  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const PaymentHistoryStatus(this.stringValue, this.stringValueForView);

  static PaymentHistoryStatus toEnumValue(String value) {
    final Map<String, PaymentHistoryStatus> stringToEnumMap = {
      PaymentHistoryStatus.card.stringValue: PaymentHistoryStatus.card,
      PaymentHistoryStatus.bank.stringValue: PaymentHistoryStatus.bank,
      PaymentHistoryStatus.paypal.stringValue: PaymentHistoryStatus.paypal,
      PaymentHistoryStatus.unknown.stringValue: PaymentHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? PaymentHistoryStatus.unknown;
  }
}

enum ShareRideHistoryStatus {
  findRide(AppConstants.ridePostAcceptanceFindRide, 'Find Ride'),
  offerRide(AppConstants.ridePostAcceptanceOfferRide, 'Offer Ride'),
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideHistoryStatus(this.stringValue, this.stringValueForView);

  static ShareRideHistoryStatus toEnumValue(String value) {
    final Map<String, ShareRideHistoryStatus> stringToEnumMap = {
      ShareRideHistoryStatus.findRide.stringValue:
          ShareRideHistoryStatus.findRide,
      ShareRideHistoryStatus.offerRide.stringValue:
          ShareRideHistoryStatus.offerRide,
      ShareRideHistoryStatus.accepted.stringValue:
          ShareRideHistoryStatus.accepted,
      ShareRideHistoryStatus.completed.stringValue:
          ShareRideHistoryStatus.completed,
      ShareRideHistoryStatus.cancelled.stringValue:
          ShareRideHistoryStatus.cancelled,
      ShareRideHistoryStatus.unknown.stringValue: ShareRideHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? ShareRideHistoryStatus.unknown;
  }
}

enum ShareRideActions {
  myRequest(AppConstants.shareRideActionMyRequest, 'Find Ride'),
  myOffer(AppConstants.shareRideActionMyOffer, 'Offer Ride'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideActions(this.stringValue, this.stringValueForView);

  static ShareRideActions toEnumValue(String value) {
    final Map<String, ShareRideActions> stringToEnumMap = {
      ShareRideActions.myRequest.stringValue: ShareRideActions.myRequest,
      ShareRideActions.myOffer.stringValue: ShareRideActions.myOffer,
      ShareRideActions.unknown.stringValue: ShareRideActions.unknown
    };
    return stringToEnumMap[value] ?? ShareRideActions.unknown;
  }
}

enum HireDriverStatus {
  hourly(AppConstants.hireDriverStatusHourly, 'Hourly'),
  fixed(AppConstants.hireDriverStatusFixed, 'Fixed');

  final String stringValue;
  final String viewableText;
  const HireDriverStatus(this.stringValue, this.viewableText);

  static HireDriverStatus toEnumValue(String value) {
    final Map<String, HireDriverStatus> stringToEnumMap = {
      HireDriverStatus.hourly.stringValue: HireDriverStatus.hourly,
      HireDriverStatus.fixed.stringValue: HireDriverStatus.fixed,
    };
    return stringToEnumMap[value] ?? HireDriverStatus.hourly;
  }
}

enum RentCarStatusStatus {
  hourly(AppConstants.rentCarStatusHourly, 'Hourly'),
  weekly(AppConstants.rentCarStatusWeekly, 'Weekly'),
  monthly(AppConstants.rentCarStatusMonthly, 'Monthly');

  final String stringValue;
  final String stringValueForView;
  const RentCarStatusStatus(this.stringValue, this.stringValueForView);

  static RentCarStatusStatus toEnumValue(String value) {
    final Map<String, RentCarStatusStatus> stringToEnumMap = {
      RentCarStatusStatus.hourly.stringValue: RentCarStatusStatus.hourly,
      RentCarStatusStatus.weekly.stringValue: RentCarStatusStatus.weekly,
      RentCarStatusStatus.monthly.stringValue: RentCarStatusStatus.monthly,
    };
    return stringToEnumMap[value] ?? RentCarStatusStatus.hourly;
  }
}

enum MessageTypeStatus {
  user(AppConstants.messageTypeStatusUser, 'User'),
  owner(AppConstants.messageTypeStatusOwner, 'Owner'),
  driver(AppConstants.messageTypeStatusDriver, 'Driver'),
  admin(AppConstants.messageTypeStatusAdmin, 'Admin');

  final String stringValue;
  final String stringValueForView;
  const MessageTypeStatus(this.stringValue, this.stringValueForView);

  static MessageTypeStatus toEnumValue(String value) {
    final Map<String, MessageTypeStatus> stringToEnumMap = {
      MessageTypeStatus.user.stringValue: MessageTypeStatus.user,
      MessageTypeStatus.owner.stringValue: MessageTypeStatus.owner,
      MessageTypeStatus.driver.stringValue: MessageTypeStatus.driver,
      MessageTypeStatus.admin.stringValue: MessageTypeStatus.admin,
    };
    return stringToEnumMap[value] ?? MessageTypeStatus.driver;
  }
}

enum CarDetailsInfoTypeStatus {
  specifications(AppConstants.vehicleDetailsInfoTypeStatusSpecifications,
      'Specifications'),
  features(AppConstants.vehicleDetailsInfoTypeStatusFeatures, 'Features'),
  documents(AppConstants.vehicleDetailsInfoTypeStatusReview, 'Documents');

  final String stringValue;
  final String stringValueForView;
  const CarDetailsInfoTypeStatus(this.stringValue, this.stringValueForView);

  static CarDetailsInfoTypeStatus toEnumValue(String value) {
    final Map<String, CarDetailsInfoTypeStatus> stringToEnumMap = {
      CarDetailsInfoTypeStatus.specifications.stringValue:
          CarDetailsInfoTypeStatus.specifications,
      CarDetailsInfoTypeStatus.features.stringValue:
          CarDetailsInfoTypeStatus.features,
      CarDetailsInfoTypeStatus.documents.stringValue:
          CarDetailsInfoTypeStatus.documents,
    };
    return stringToEnumMap[value] ?? CarDetailsInfoTypeStatus.specifications;
  }
}

enum RideDriverTabStatus {
  accepted(AppConstants.hireDriverListEnumAccept, 'Accepted'),
  started(AppConstants.hireDriverListEnumStarted, 'Started'),
  userPending(AppConstants.hireDriverListEnumUserPending, 'User Pending'),
  driverPending(AppConstants.hireDriverListEnumDriverPending, 'Driver Pending'),
  completed(AppConstants.hireDriverListEnumComplete, 'Completed'),
  cancelled(AppConstants.hireDriverListEnumCancel, 'Cancelled');

  final String stringValue;
  final String stringValueForView;
  const RideDriverTabStatus(this.stringValue, this.stringValueForView);

  static RideDriverTabStatus toEnumValue(String value) {
    final Map<String, RideDriverTabStatus> stringToEnumMap = {
      RideDriverTabStatus.accepted.stringValue: RideDriverTabStatus.accepted,
      RideDriverTabStatus.started.stringValue: RideDriverTabStatus.started,
      RideDriverTabStatus.userPending.stringValue:
          RideDriverTabStatus.userPending,
      RideDriverTabStatus.driverPending.stringValue:
          RideDriverTabStatus.driverPending,
      RideDriverTabStatus.completed.stringValue: RideDriverTabStatus.completed,
      RideDriverTabStatus.cancelled.stringValue: RideDriverTabStatus.cancelled,
    };
    return stringToEnumMap[value] ?? RideDriverTabStatus.driverPending;
  }
}

enum ShareRideAllStatus {
  active(AppConstants.shareRideAllStatusActive, 'Active'),
  accepted(AppConstants.shareRideAllStatusAccepted, 'Accepted'),
  reject(AppConstants.shareRideAllStatusRejected, 'Rejected'),
  pending(AppConstants.shareRideAllStatusPending, 'Pending'),
  started(AppConstants.shareRideAllStatusStarted, 'Started'),
  completed(AppConstants.shareRideAllStatusCompleted, 'Completed'),
  cancelled(AppConstants.shareRideAllStatusCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;

  const ShareRideAllStatus(this.stringValue, this.stringValueForView);

  static ShareRideAllStatus toEnumValue(String value) {
    final Map<String, ShareRideAllStatus> stringToEnumMap = {
      ShareRideAllStatus.active.stringValue: ShareRideAllStatus.active,
      ShareRideAllStatus.accepted.stringValue: ShareRideAllStatus.accepted,
      ShareRideAllStatus.reject.stringValue: ShareRideAllStatus.reject,
      ShareRideAllStatus.pending.stringValue: ShareRideAllStatus.pending,
      ShareRideAllStatus.started.stringValue: ShareRideAllStatus.started,
      ShareRideAllStatus.completed.stringValue: ShareRideAllStatus.completed,
      ShareRideAllStatus.cancelled.stringValue: ShareRideAllStatus.cancelled,
    };
    return stringToEnumMap[value] ?? ShareRideAllStatus.unknown;
  }
}

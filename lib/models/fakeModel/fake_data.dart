// import 'fake_models/bid_category_model.dart';

import 'package:one_ride_user/models/fakeModel/intro_content_model.dart';
import 'package:one_ride_user/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';

class FakeData {
  // Intro screens
  static List<FakeIntroContent> fakeIntroContents = [
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro1.png',
        slogan: AppLanguageTranslation.bookYourCarTransKey.toCurrentLanguage,
        content:
            AppLanguageTranslation.slogan1ContentTransKey.toCurrentLanguage),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro2.png',
        slogan: AppLanguageTranslation.atAnytimeTransKey.toCurrentLanguage,
        content:
            AppLanguageTranslation.slogan2ContentTransKey.toCurrentLanguage),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro3.png',
        slogan: AppLanguageTranslation.anywhereYouAreTransKey.toCurrentLanguage,
        content:
            AppLanguageTranslation.slogan2ContentTransKey.toCurrentLanguage),
  ];
  // Payment options
  static List<FakePaymentOptionModel> paymentOptions = [
    FakePaymentOptionModel(
        id: '2',
        name: 'paypal',
        paymentImage:
            'https://w1.pngwing.com/pngs/138/644/png-transparent-paypal-logo-text-line-blue.png'),
    /* FakePaymentOptionModel(
        id: '121211',
        name: 'Cash',
        paymentImage:
            'https://w7.pngwing.com/pngs/388/612/png-transparent-money-money-bag-saving-image-file-formats-hand-thumbnail.png'),
    FakePaymentOptionModel(
        id: '111111',
        name: 'Credit card',
        paymentImage:
            'https://w7.pngwing.com/pngs/962/794/png-transparent-mastercard-credit-card-mastercard-logo-mastercard-logo-love-text-heart.png'),
    FakePaymentOptionModel(
        id: '22222222',
        name: 'Tmoney',
        paymentImage:
            'https://freelogopng.com/images/all_img/1656235223bkash-logo.png'),
    FakePaymentOptionModel(
        id: '333333333',
        name: 'Move to Money',
        paymentImage:
            'https://freelogopng.com/images/all_img/1679248787Nagad-Logo.png'), */
  ];

  static List<RecentSalesContent> recentSales = [
    RecentSalesContent(
      courseName: 'JavaScript for Beginners',
      price: 90,
    ),
    RecentSalesContent(
      courseName: 'Flutter for Beginners',
      price: 200.50,
    ),
    RecentSalesContent(
      courseName: 'C++ for Beginners',
      price: 225.5,
    ),
    RecentSalesContent(
      courseName: 'Dart for Beginners',
      price: 50.6,
    )
  ];

  static var cancelRideReason = <FakeCancelRideReason>[
    FakeCancelRideReason(reasonName: 'Waiting for a long time '),
    FakeCancelRideReason(reasonName: 'Ride isn\'t here '),
    FakeCancelRideReason(reasonName: 'Wrong address shown'),
    FakeCancelRideReason(reasonName: 'Don\'t charge rider'),
    FakeCancelRideReason(reasonName: 'Other'),
  ];
  static var paymentOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage:
            'https://icons.iconarchive.com/icons/flat-icons.com/flat/512/Wallet-icon.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/8808/8808875.png',
        value: 'cash',
        viewAbleName: 'Cash'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];
}

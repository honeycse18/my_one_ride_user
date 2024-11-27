import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:one_ride_user/screens/accept_ride_request_screen.dart';
import 'package:one_ride_user/screens/add_credit_card_screen.dart';
import 'package:one_ride_user/screens/add_locatoin_screen.dart';
import 'package:one_ride_user/screens/admin_chat_screen_details.dart';
import 'package:one_ride_user/screens/all_transaction_screen.dart';
import 'package:one_ride_user/screens/car_rent_summary_screen.dart';
import 'package:one_ride_user/screens/change_password_screen.dart';
import 'package:one_ride_user/screens/choose_you_need_screen.dart';
import 'package:one_ride_user/screens/create_new_password_screen.dart';
import 'package:one_ride_user/screens/delete_account.dart';
import 'package:one_ride_user/screens/home_screen_without_login.dart';
import 'package:one_ride_user/screens/email_login_screen.dart';
import 'package:one_ride_user/screens/hire_driver_details_screen.dart';
import 'package:one_ride_user/screens/hire_driver_start_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/chat_screen.dart';
// import 'package:one_ride_user/screens/login_password_screen.dart';
// import 'package:one_ride_user/screens/login_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/home_navigator_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/home_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/picked_location_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/privacy_policy_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/profile_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/ride_share_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/terms_and_condition_screen.dart';
import 'package:one_ride_user/screens/intro_screen.dart';
import 'package:one_ride_user/screens/make_payment_screen.dart';
import 'package:one_ride_user/screens/menu_screen/about_us_screen.dart';
import 'package:one_ride_user/screens/menu_screen/add_hire_driver_screen.dart';
import 'package:one_ride_user/screens/menu_screen/car_rent_details_screen.dart';
import 'package:one_ride_user/screens/menu_screen/car_rent_list_details_screen.dart';
import 'package:one_ride_user/screens/menu_screen/contact_us_.dart';
import 'package:one_ride_user/screens/menu_screen/favourit_screen.dart';
import 'package:one_ride_user/screens/menu_screen/help_support_screen.dart';
import 'package:one_ride_user/screens/menu_screen/hire_driver_screen.dart';
import 'package:one_ride_user/screens/menu_screen/hired_driver_details_screen.dart';
import 'package:one_ride_user/screens/menu_screen/languagescreen/language_screen.dart';
import 'package:one_ride_user/screens/menu_screen/rent_car_screen.dart';
import 'package:one_ride_user/screens/menu_screen/ride_list_screen.dart';
import 'package:one_ride_user/screens/menu_screen/saved_locations_screen.dart';
import 'package:one_ride_user/screens/menu_screen/settings_screen.dart';
import 'package:one_ride_user/screens/my_wallet_screen.dart';
import 'package:one_ride_user/screens/notification_screen.dart';
import 'package:one_ride_user/screens/offer_screen.dart';
import 'package:one_ride_user/screens/password_change_success_screen.dart';
import 'package:one_ride_user/screens/password_recovery_select_screen.dart';
import 'package:one_ride_user/screens/payment_method_screen.dart';
import 'package:one_ride_user/screens/pulling_offer_details_screen.dart';
import 'package:one_ride_user/screens/pulling_request-overview_screen.dart';
import 'package:one_ride_user/screens/pulling_request_details_screen.dart';
import 'package:one_ride_user/screens/referal_screen.dart';
import 'package:one_ride_user/screens/rent_car_list_screen.dart';
import 'package:one_ride_user/screens/saved_card_list_screen.dart';
import 'package:one_ride_user/screens/security_screens/login_password_screen.dart';
import 'package:one_ride_user/screens/security_screens/login_screen.dart';
import 'package:one_ride_user/screens/security_screens/sign_up_screen.dart';
import 'package:one_ride_user/screens/security_screens/verification_screen.dart';
import 'package:one_ride_user/screens/select_car_screen.dart';
import 'package:one_ride_user/screens/select_location_screen.dart';
import 'package:one_ride_user/screens/select_payment_methods_screen.dart';
import 'package:one_ride_user/screens/select_payment_methods_screen_hire_driver.dart';
import 'package:one_ride_user/screens/select_payment_screen.dart';
import 'package:one_ride_user/screens/splash_screen.dart';
import 'package:one_ride_user/screens/topup_screen.dart';
import 'package:one_ride_user/screens/unknown_screen.dart';
import 'package:one_ride_user/screens/view_request_screen.dart';
import 'package:one_ride_user/screens/withdraw/payment_method_bank.dart';
import 'package:one_ride_user/screens/withdraw/payment_method_card.dart';
import 'package:one_ride_user/screens/withdraw/payment_method_paypal.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.logInScreen, page: () => const LoginScreen()),
    GetPage(name: AppPageNames.homeScreen, page: () => const HomeScreen()),
    GetPage(
        name: AppPageNames.selectLocationScreen,
        page: () => const SelectLocationScreen()),
    GetPage(
        name: AppPageNames.registrationScreen,
        page: () => const RegistrationScreen()),
    GetPage(
        name: AppPageNames.chooseYouNeedScreen,
        page: () => const ShareRideOverviewScreen()),
    GetPage(
        name: AppPageNames.selectLocation,
        page: () => const SelectLocationScreen()),
    GetPage(
        name: AppPageNames.homeNavigatorScreen,
        page: () => const HomeNavigatorScreen()),
    GetPage(
        name: AppPageNames.verificationScreen,
        page: () => const VerificationScreen()),
    GetPage(name: AppPageNames.offerScreen, page: () => const OfferScreen()),
    GetPage(
      name: AppPageNames.hireDriverDetailsScreen,
      page: () => const HireDriverDetailsScreen(),
    ),
    GetPage(
        name: AppPageNames.logInPasswordScreen,
        page: () => const LogInPasswordScreen()),
    GetPage(
        name: AppPageNames.emailLogInScreen,
        page: () => const EmailLoginScreen()),
    GetPage(
        name: AppPageNames.emailLogInScreen,
        page: () => const EmailLoginScreen()),
    GetPage(
        name: AppPageNames.referalScreen, page: () => const ReferalScreen()),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
        name: AppPageNames.languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryScreen,
        page: () => const PasswordRecoverySelectScreen()),
    GetPage(
        name: AppPageNames.createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen()),
    GetPage(
        name: AppPageNames.passwordChangedScreen,
        page: () => const PasswordChangSuccessScreen()),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
        name: AppPageNames.pickedLocationScreen,
        page: () => const PickedLocationScreen()),
    GetPage(
        name: AppPageNames.rideListCarScreen,
        page: () => const RideListCarScreen()),
    GetPage(
        name: AppPageNames.selectCarScreen,
        page: () => const SelectCarScreen()),
    GetPage(
        name: AppPageNames.acceptedRequestScreen,
        page: () => const AcceptedRideRequestScreen()),
    GetPage(
        name: AppPageNames.aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(
        name: AppPageNames.helpSupportScreen,
        page: () => const HelpSupportScreen()),
    GetPage(
        name: AppPageNames.savedLocationsScreen,
        page: () => const SavedLocationsScreen()),
    GetPage(
        name: AppPageNames.paymentMethodPaypalScreen,
        page: () => const PaymentMethodPaypalScreen()),
    GetPage(
        name: AppPageNames.paymentMethodBankScreen,
        page: () => const PaymentMethodBankScreen()),
    GetPage(
        name: AppPageNames.paymentMethodCardScreen,
        page: () => const PaymentMethodCardScreen()),
    GetPage(
        name: AppPageNames.addLocationScreen,
        page: () => const AddLocationScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: AppPageNames.termsConditionScreen,
        page: () => const TermsConditionScreen()),
    GetPage(
        name: AppPageNames.adminChatScreen,
        page: () => const AdminChatScreen()),
    GetPage(
        name: AppPageNames.changePasswordPromptScreen,
        page: () => const ChangePasswordPromptScreen()),
    GetPage(
        name: AppPageNames.hiredDriverDetailsScreen,
        page: () => const HiredDriverDetailsScreen()),
    GetPage(
        name: AppPageNames.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: AppPageNames.myWalletScreen, page: () => const MyWalletScreen()),
    GetPage(name: AppPageNames.topupScreen, page: () => const TopupScreen()),
    GetPage(
        name: AppPageNames.hireDriverSelectPaymentMethodsScreen,
        page: () => const HireDriverSelectPaymentMethodsScreen()),
    GetPage(
        name: AppPageNames.rideShareScreen,
        page: () => const RideShareScreen()),
    GetPage(
        name: AppPageNames.deleteAccount, page: () => const DeleteAccount()),
    GetPage(
        name: AppPageNames.hireDriverScreen,
        page: () => const HireDriverScreen()),
    GetPage(
        name: AppPageNames.hireDriverStartScreen,
        page: () => const HireDriverStartScreen()),
    GetPage(
        name: AppPageNames.allTransactionScreen,
        page: () => const AllTransactionScreen()),
    GetPage(
        name: AppPageNames.addCardScreen, page: () => const AddCardScreen()),
    GetPage(
        name: AppPageNames.rentCarListScreen,
        page: () => const RentCarListScreen()),
    GetPage(
        name: AppPageNames.demoScreen,
        page: () => const HomeScreenWithoutLogin()),
    GetPage(
        name: AppPageNames.selectPaymentMethodScreen,
        page: () => const SelectPaymentScreen()),
    GetPage(
        name: AppPageNames.savedcardListScreen,
        page: () => const SavedcardListScreen()),
    GetPage(
      name: AppPageNames.addHireDriverScreen,
      page: () => const AddHireDriverScreen(),
    ),
    GetPage(
      name: AppPageNames.carRentListDetailsScreen,
      page: () => const CarRentListDetailsScreen(),
    ),
    GetPage(
      name: AppPageNames.carRentSummaryScreen,
      page: () => const CarRentSummaryScreen(),
    ),
    GetPage(
      name: AppPageNames.contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(name: AppPageNames.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: AppPageNames.paymentMethodScreen,
        page: () => PaymentMethodScreen()),
    GetPage(
        name: AppPageNames.carDetailsScreen,
        page: () => const CarDetailsScreen()),
    GetPage(
        name: AppPageNames.rentCarScreen, page: () => const RentCarScreen()),
    GetPage(
        name: AppPageNames.selectPaymentMethodsScreen,
        page: () => const SelectPaymentMethodsScreen()),
    GetPage(
        name: AppPageNames.favouritListScreen,
        page: () => const FavouritListScreen()),
    GetPage(
        name: AppPageNames.viewRequestsScreen,
        page: () => const ViewRequestsScreen()),
    GetPage(
        name: AppPageNames.pullingRequestOverviewScreen,
        page: () => const PullingRequestOverviewScreen()),
    GetPage(
        name: AppPageNames.myProfileScreen,
        page: () => const MyAccountScreen()),
    GetPage(
        name: AppPageNames.pullingOfferDetailsScreen,
        page: () => const PullingOfferDetailsScreen()),
    GetPage(
        name: AppPageNames.pullingRequestDetailsScreen,
        page: () => const PullingRequestDetailsScreen()),
    GetPage(
        name: AppPageNames.makePaymentScreen,
        page: () => const MakePaymentScreen()),
  ];

  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
      name: AppPageNames.unknownScreen, page: () => const UnknownScreen());
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';

class AppSingleton {
  static AppSingleton? _instance;

  late Box localBox;
  Future<void> initialize() async {
    await Hive.initFlutter();
    localBox = await Hive.openBox(AppConstants.hiveBoxName);
  }

  // SiteSettings settings = SiteSettings.empty();
  CameraPosition defaultCameraPosition = AppConstants.defaultMapCameraPosition;
  // late Box localBox;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  AppSingleton._();

  // static void _onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     log('notification payload: $payload');
  //   }
  //   // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  // }

  // static void _onDidReceiveBackgroundNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     log('background notification payload: $payload');
  //   }
  //   // await Navigator.push( context, MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),);
  // }

  // void _initializeLocalNotification() async {
  //   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   // initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       // AndroidInitializationSettings('app_icon');
  //       AndroidInitializationSettings('@mipmap/launcher_icon');
  //   // final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings( onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     // iOS: initializationSettingsDarwin,
  //     // macOS: initializationSettingsDarwin,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
  //       onDidReceiveBackgroundNotificationResponse:
  //           _onDidReceiveBackgroundNotificationResponse);
  // }

  // Future<void> initialize() async {
  //   localBox = await Hive.openBox(Constants.hiveBoxName);
  //   _initializeLocalNotification();
  // }

  static AppSingleton get instance => _instance ??= AppSingleton._();
}

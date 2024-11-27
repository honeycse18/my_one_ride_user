import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:one_ride_user/screens/home_navigator_screen/home_navigator_screen.dart';
import 'package:one_ride_user/screens/security_screens/login_screen.dart';
import 'package:one_ride_user/screens/splash_screen.dart';
import 'package:one_ride_user/utils/app_pages.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  await AppSingleton.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const OneRideUserApp());
}

class OneRideUserApp extends StatelessWidget {
  const OneRideUserApp({Key? key}) : super(key: key);

  // This widget is the root of this app.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OneRide',
      getPages: AppPages.pages,
      // onGenerateRoute: AppRouteGenerator.generateRoute,
      unknownRoute: AppPages.unknownScreenPageRoute,
      initialRoute: AppPageNames.rootScreen,
      theme: AppThemeData.appThemeData,
      // home: UpgradeAlert(child: const SplashScreen()),
      // initialBinding: AppBindings(),
    );
  }
}

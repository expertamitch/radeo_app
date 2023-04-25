import 'package:get/get.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/authentication/welcome_page.dart';

import '../screens/authentication/login_page.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        transition: Transition.cupertino,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.mainScreen,
      transition: Transition.cupertino,
      page: () => WelcomePage(),
      // binding: SplashBinding()
    ),
    GetPage(
      name: Routes.loginScreen,
      transition: Transition.cupertino,
      page: () => LoginPage(),
      // binding: SplashBinding()
    ),
  ];
}

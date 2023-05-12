import 'package:get'
    '/get.dart';
import 'package:redeo/screens/splash/splash_controller.dart';

import '../home/home_page_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      () => HomePageController(),
      permanent: true,
    );

    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}

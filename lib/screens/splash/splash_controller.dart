import 'package:get/get.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/route/routes.dart';

import '../authentication/controller/auth_controller.dart';

class SplashController extends GetxController {

  AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(), permanent: true);

  bool started = false;

  start() async {
    if (!started) {
      started = true;
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        if (StorageUtils.getToken().isEmpty) {
          Get.offAndToNamed(Routes.mainScreen);
        } else
          Get.offAndToNamed(Routes.homepageScreen);
      });
    }
  }
}

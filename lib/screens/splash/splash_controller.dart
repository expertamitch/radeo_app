import 'package:get/get.dart';

import '../../network/storage_utils.dart';
import '../../route/routes.dart';

class SplashController extends GetxController {
  bool started = false;


  start() async {
    if (!started) {
      started = true;
      Future.delayed(const Duration(seconds: 3)).then((value) async {

      });
    }
  }
}

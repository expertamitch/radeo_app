import 'package:get/get.dart';

class SplashController extends GetxController {
  bool started = false;

  start() async {
    if (!started) {
      started = true;
      Future.delayed(const Duration(seconds: 3)).then((value) async {});
    }
  }
}

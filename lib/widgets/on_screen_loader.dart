import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../assets/images.dart';

class OnScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Images.loader,
      width: Get.width * 0.2,
      height: Get.width * 0.2,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/splash/splash_controller.dart';

import '../../assets/images.dart';
import '../../widgets/image_view.dart';

class SplashScreen extends StatelessWidget {

  SplashController controller = Get.isRegistered<SplashController>()
      ? Get.find<SplashController>()
      : Get.put(SplashController(), permanent: true);



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    controller.start();

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body:   Center(
          child: ImageView(
            path: Images.icSplashIcon,

          ),
        ),
      ),
    );
  }


}

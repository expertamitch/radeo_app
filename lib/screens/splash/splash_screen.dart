import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/splash/splash_controller.dart';

import '../../assets/images.dart';
import '../../widgets/image_view.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: Get.width / 3.5,
              child: const ImageView(
                path: Images.icLoading,
              ),
            ),
            getLogo(),
            Positioned(
              bottom: 0,
              left: 0,
              right: Get.width / 3.5,
              child: const ImageView(
                path: Images.icLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogo() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageView(
          path: Images.icLoading,
          width: 54.w,
          height: 59.h,
        ),
        SizedBox(
          width: 15.w,
        ),
        ImageView(
          path: Images.icLoading,
          width: 110.w,
          height: 35.h,
        )
      ],
    ));
  }
}

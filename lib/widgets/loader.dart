import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../assets/images.dart';
import 'image_view.dart';


showLoader() {
  Get.dialog(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            width: (Get.width) - 48.w,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 50.h),
            child: Lottie.asset(Images.loader,width: Get.width*0.2, height: Get.width*0.2, ),
          ),
        ],
      ),barrierDismissible: false
  );
}

hideLoader() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) Get.back();
}

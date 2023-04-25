import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../assets/images.dart';
import '../styling/app_colors.dart';
import 'image_view.dart';

showLoader() {
  Get.dialog(
    Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: AppColors.white,
            width: (Get.width) - 48.w,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 20.h),
            child: ImageView(
              path: Images.icLoading,
            ),
          ),
        ],
      ),
    ),
  );
}

hideLoader() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) Get.back();
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../assets/images.dart';
import '../styling/app_colors.dart';
import '../widgets/image_view.dart';

showErrorSnackBar(String message) {
  var snackBar = SnackBar(
    content: Row(
      children: [
        ImageView(
          path: Images.dangerTtriangle,
          width: 20.w,
          height: 18.h,
          color: Color(0XFFDB6565),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
            child: Text(
          message,
          style: w300_12(color: AppColors.dark2GreyColor),
        )),
      ],
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    backgroundColor: Color(0XFFFFE7E7),
    margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
    behavior: SnackBarBehavior.floating,

  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

}
showSuccessSnackBar(String message) {
  var snackBar = SnackBar(
    content: Row(
      children: [
        Icon(Icons.done, color: Colors.white,),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
            child: Text(
          message,
          style: w300_12(color: Colors.white),
        )),
      ],
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    backgroundColor: Colors.green,
    margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
    behavior: SnackBarBehavior.floating,

  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

  //
  // Get.snackbar('', message,
  //     titleText: Text(''),
  //     backgroundColor: Color(0XFFFFE7E7),
  //     //color: Color(0XFFDB6565),
  //     icon: ImageView(
  //       path: Images.dangerTtriangle,
  //       width: 20.w,
  //       height: 18.h,
  //       color: Color(0XFFDB6565),
  //     ),
  //     borderRadius: 5,
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
  //     margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
  //     isDismissible: true,
  //     dismissDirection: DismissDirection.horizontal,
  //     forwardAnimationCurve: Curves.easeOutBack,
  //     colorText: AppColors.lightGrey,
  //     snackPosition: SnackPosition.BOTTOM);
}

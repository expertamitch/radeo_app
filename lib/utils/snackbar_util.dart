import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../assets/images.dart';
import '../main.dart';
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
    elevation: 1,
    behavior: SnackBarBehavior.floating,

  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

}
//
// showErrorSnackBar(
//   String msg,
// ) {
//   FToast fToast = FToast();
//   fToast.init(NavigationService.navigatorKey.currentContext!);
//
//   Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0), color: Colors.grey[900]),
//       child: Text(msg,
//           style: const TextStyle(
//               fontFamily: 'FuturaNext', color: Colors.white, fontSize: 14)));
//
//   fToast.showToast(
//     child: toast,
//     gravity: ToastGravity.BOTTOM,
//   );
// }

showSuccessSnackBar(String message) {
  var snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          Icons.done,
          color: Colors.white,
        ),
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

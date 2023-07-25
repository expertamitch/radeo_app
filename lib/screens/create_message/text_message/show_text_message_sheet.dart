import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/bottom_sheet_with_button_widget.dart';

import '../../../../styling/font_style_globle.dart';
import '../../../widgets/bottom_sheet_widget.dart';

Future<dynamic> showTextMessageBottomSheet(String textMessage) {
  return Get.bottomSheet(
    BottomSheetWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height - 300),
              child: SingleChildScrollView(
                child: Text(
                  textMessage,
                  textAlign: TextAlign.left,
                  style: w300_15(),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );

  return Get.bottomSheet(
    BottomSheetWithButtonWidget(
      saveCallback: () async {},
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(
          textMessage,
          textAlign: TextAlign.left,
          style: w300_15(),
        ),
      ),
    ),
    isScrollControlled: true,
  );
}

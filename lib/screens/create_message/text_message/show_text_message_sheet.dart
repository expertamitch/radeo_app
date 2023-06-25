import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/bottom_sheet_with_button_widget.dart';

import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/bottom_sheet_widget.dart';

showTextMessageBottomSheet(String textMessage) {
  return Get.bottomSheet(
    BottomSheetWithButtonWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textMessage ,
              style: w300_15(),
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}

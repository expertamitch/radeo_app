import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/bottom_sheet_widget.dart';

showIdTypeBottomSheet() {
  return Get.bottomSheet(
    BottomSheetWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select ID type',
              style: w900_15(color: AppColors.dark2GreyColor),
            ),
            SizedBox(
              height: 25.h,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height - 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      'Article',
                      style: w600_13(),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      'Video',
                      style: w600_13(),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      'Brochure',
                      style: w600_13(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}

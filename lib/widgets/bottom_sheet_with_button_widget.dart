import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

import '../assets/images.dart';
import 'image_view.dart';

class BottomSheetWithButtonWidget extends StatelessWidget {
  BottomSheetWithButtonWidget({
    required this.child,
  });

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: AppButton(
                          onPressedFunction: () {
                            Get.back();
                          },
                          child: Text(
                            ' Save ',
                            style: w300_12(color: Colors.white),
                          ),
                          sodiumShapeBorder: true,
                          width: null,
                          height: 30.h,
                          buttonColor: AppColors.purpleColor),
                    ),
                    SizedBox(width: 15.w),
                    Align(
                      alignment: Alignment.topRight,
                      child: AppButton(
                          onPressedFunction: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: w300_12(color: Colors.white),
                          ),
                          sodiumShapeBorder: true,
                          width: null,
                          height: 30.h,
                          buttonColor: AppColors.purpleColor),
                    )
                  ],
                ),
              ),
              child,
              SizedBox(height: 15.w)
            ],
          ),
        )
      ],
    );
  }
}

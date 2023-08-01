import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class DisabledTextField extends StatelessWidget {
  String hint;
  String? mainHint;
  String? text;
  String? error;
  bool showError;
  VoidCallback? onTap;

  DisabledTextField({required this.hint, required this.showError, this.onTap, this.error, this.mainHint, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hint,
                  style: w300_13(
                    color: AppColors.blueColor,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  text ?? mainHint ?? hint,
                  style: w300_13(),
                ),
              ],
            ),
          ),
        ),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              error!,
              style: w300_13(
                color: AppColors.redColor,
              ),
            ),
          ),
      ],
    );
  }
}

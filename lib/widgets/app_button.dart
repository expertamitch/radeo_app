import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:redeo/styling/app_colors.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final Function onPressedFunction;
  final Widget child;
  final double height;
  final Color buttonColor;
  final double? width;
  final bool sodiumShapeBorder;

  const AppButton(
<<<<<<< HEAD
      {Key? key,
      required this.onPressedFunction,
      required this.child,
      required this.height,
      required this.buttonColor,
      this.sodiumShapeBorder = false,
      this.width = double.maxFinite})
      : super(key: key);
=======
      {
      required this.txt,
      this.textColor = Colors.white,
      this.fontFamily = 'helvetica_neue',
      this.fontWeight = FontWeight.w600,
      this.textSize,
      this.fillColor = Colors.black,
      this.width,
      this.leftWidget,
      this.margin,
      this.borderColor,
      this.padding,
      this.textAlign,
      this.onPressed});
>>>>>>> origin/font_fixes

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: sodiumShapeBorder
                    ? StadiumBorder()
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                primary: buttonColor),
            onPressed: () {
              onPressedFunction();
            },
            child: child));
  }
}

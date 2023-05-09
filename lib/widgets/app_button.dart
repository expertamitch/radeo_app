import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeo/styling/app_colors.dart';

  import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String txt;
  final Color textColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final double? textSize;
  final Color fillColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextAlign? textAlign;
  final Widget? leftWidget;

  const AppButton(
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.all(Radius.circular(20.sp)),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
leftWidget??Container(width: 0,),
            AppText(
              text: txt,
              color: textColor,
              fontFamily: fontFamily,
              textAlign: textAlign ?? TextAlign.center,
              fontWeight: fontWeight,
              textSize: textSize ?? 36.sp,
            ),
          ],
        ),
      ),
    );
  }
}

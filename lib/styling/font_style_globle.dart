import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontRegular = "helvetica_regular";
const String fontMedium = "helvetica_medium";
const String fontBold = "helvetica_bold";
const double margin = 20;

/*
* w300 -> regular
* w600 -> medium
* w900 -> bold
* */

TextStyle w300_10({Color? color = Colors.black}) {
  return TextStyle(fontSize: 10.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_13({Color? color = Colors.black}) {
  return TextStyle(fontSize: 13.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_12({Color? color = Colors.black}) {
  return TextStyle(fontSize: 12.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_14({Color? color = Colors.black}) {
  return TextStyle(fontSize: 14.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_15({Color? color = Colors.black}) {
  return TextStyle(fontSize: 15.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_16({Color? color = Colors.black}) {
  return TextStyle(fontSize: 16.sp, color: color, fontFamily: fontRegular);
}

TextStyle w300_20({Color? color = Colors.black}) {
  return TextStyle(fontSize: 20.sp, color: color, fontFamily: fontRegular);
}

TextStyle w600_14({Color? color = Colors.black}) {
  return TextStyle(fontSize: 14.sp, color: color, fontFamily: fontMedium);
}

TextStyle w600_35({Color? color = Colors.black}) {
  return TextStyle(fontSize: 35.sp, color: color, fontFamily: fontMedium);
}

TextStyle w600_12({Color? color = Colors.black}) {
  return TextStyle(fontSize: 12.sp, color: color, fontFamily: fontMedium);
}

TextStyle w600_16({Color? color = Colors.black}) {
  return TextStyle(fontSize: 16.sp, color: color, fontFamily: fontMedium);
}

TextStyle w600_20({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: fontBold);
}

TextStyle w900_16({Color? color = Colors.black}) {
  return TextStyle(fontSize: 16.sp, color: color, fontFamily: fontBold);
}

TextStyle w900_15({Color? color = Colors.black}) {
  return TextStyle(fontSize: 15.sp, color: color, fontFamily: fontBold);
}

TextStyle w900_30({Color? color = Colors.black}) {
  return TextStyle(fontSize: 30.sp, color: color, fontFamily: fontBold);
}

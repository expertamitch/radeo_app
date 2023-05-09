import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontName = "helvetica_neue";
const double margin = 20;

/*
* w300 -> regular
* w600 -> medium
* w900 -> bold
* */

TextStyle w300_10({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_13({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_12({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_14({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_15({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_16({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w300_20({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w300,
      color: color,
      fontFamily: fontName);
}

TextStyle w600_14({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: fontName);
}

TextStyle w600_35({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 35.sp,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: fontName);
}

TextStyle w600_12({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: fontName);
}

TextStyle w600_16({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: fontName);
}

TextStyle w900_15({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w900,
      color: color,
      fontFamily: fontName);
}

TextStyle w900_30({Color? color = Colors.black}) {
  return TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w900,
      color: color,
      fontFamily: fontName);
}

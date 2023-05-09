import 'package:flutter/material.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/styling/font_style_globle.dart';

// Color purpleColor = Color(0xff6E1475);
// Color greyColor = Color(0xffE2E2E2);
// Color lighBlueColor = Color(0xff73BAD9);

InputDecoration inputDecoration = InputDecoration(
  labelStyle: w300_14(
    color: AppColors.dark2GreyColor,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.greyColor),
    borderRadius: BorderRadius.circular(14),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.greyColor),
    borderRadius: BorderRadius.circular(14),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.greyColor),
    borderRadius: BorderRadius.circular(14),
  ),
);

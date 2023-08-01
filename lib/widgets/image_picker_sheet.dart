import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../styling/app_colors.dart';
import '../styling/font_style_globle.dart';
import 'app_button.dart';
import 'bottom_sheet_widget.dart';

Future showChooseImage() {
  File? file;
  return Get.bottomSheet(
      BottomSheetWidget(
          child: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h),
            child: Column(
              children: [
                AppButton(
                    onPressedFunction: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                          imageQuality: 40
                      );
                      if (pickedFile != null) {
                        file = File(pickedFile.path);

                        Get.back(result: file);
                      }
                    },
                    child: Text(
                      'Camera',
                      style: w900_15(color: Colors.white),
                    ),
                    height: 50.h,
                    buttonColor: AppColors.purpleColor),
                SizedBox(
                  height: 8.h,
                ),
                AppButton(
                    onPressedFunction: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 40
                      );
                      if (pickedFile != null) {
                        file = File(pickedFile.path);

                        Get.back(result: file);
                      }
                    },
                    child: Text(
                      'Gallery',
                      style: w900_15(color: Colors.white),
                    ),
                    height: 50.h,
                    buttonColor: AppColors.purpleColor),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          )),
      isScrollControlled: true);
}
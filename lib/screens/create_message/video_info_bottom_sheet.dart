import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/route/routes.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/snackbar_util.dart';
import '../../utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet_widget.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_view.dart';

Future showVideoInfoBottomSheet({String type = 'video'}) {


  return Get.bottomSheet(
    BottomSheetWidget(
      child: ImageA(),
    ),
    isScrollControlled: true,
  );
}

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


class ImageA extends StatefulWidget{

  @override
  _ImageAState createState()=> _ImageAState();
}

class _ImageAState extends State<ImageA>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? imageFile;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Fill following info',
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
                    child: imageFile != null
                        ? ImageView(
                      file: imageFile!,
                      height: 80.w,
                      width: 80.w,
                    )
                        :ImageView(
                      path: Images.icDefault,
                      height: 80.w,
                      width: 80.w,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppButton(
                      onPressedFunction: () async {
                        showChooseImage().then((value) {
                          if (value != null && value is File) {
                            imageFile = value;


                            setState(() {

                            });
                          }
                        });
                      },
                      child: Text(
                        'Choose Thumbnail',
                        style: w900_15(color: Colors.white),
                      ),
                      height: 40.h,
                      width: Get.width *0.7,
                      buttonColor: AppColors.purpleColor),

                  SizedBox(
                    height: 20.h,
                  ),

                  TextFormField(
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration:
                    inputDecoration.copyWith(labelText: 'File name'),
                    validator: (value) => Validators.validateName(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                      onPressedFunction: () async {
                        if (imageFile == null ) {
                          showErrorSnackBar('Please select thumbnail.');

                          return;
                        }
                        if (_formKey.currentState!.validate())
                          Get.back(result: {
                            'name': nameController.text,
                            'file': imageFile!.path
                          });
                      },
                      child: Text(
                        'Save',
                        style: w900_15(color: Colors.white),
                      ),
                      height: 50.h,
                      buttonColor: AppColors.purpleColor),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}



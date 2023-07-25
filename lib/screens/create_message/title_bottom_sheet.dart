import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet_widget.dart';
import '../../widgets/colors.dart';

Future showTitleBottomSheet({String type = 'video'}) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  return Get.bottomSheet(
    BottomSheetWidget(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Give this $type a name',
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
                          if (_formKey.currentState!.validate())
                            Get.back(result: nameController.text);
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
      ),
    ),
    isScrollControlled: true,
  );
}

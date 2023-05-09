import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import 'package:redeo/widgets/app_button.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                AppButton(
                    onPressedFunction: () {},
                    child: Text(
                      'Save',
                      style: w700_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Create Group',
              style: w700_30(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Group Name',
              style: w400_13(
                color: AppColors.blueColor,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              style: w300_14(),
              decoration: InputDecoration(
                  hintStyle: w300_14(
                    color: AppColors.dark2GreyColor,
                  ),
                  hintText: 'Group Name',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Select Member',
                  style: w400_13(
                    color: AppColors.blueColor,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 18.w,
                ),
              ),
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.inviteeScreen);
                  },
                  child: Text(
                    'Select',
                    style: w700_12(color: Colors.white),
                  ),
                  sodiumShapeBorder: true,
                  width: null,
                  height: 30.h,
                  buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 18.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Select Attendants',
                  style: w400_13(
                    color: AppColors.blueColor,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 18.w,
                ),
              ),
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.attendantsScreen);
                  },
                  child: Text(
                    'Select',
                    style: w700_12(color: Colors.white),
                  ),
                  sodiumShapeBorder: true,
                  width: null,
                  height: 30.h,
                  buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 18.w,
              ),
            ],
          )
        ]));
  }
}

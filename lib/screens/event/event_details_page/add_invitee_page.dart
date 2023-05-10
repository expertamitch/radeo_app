import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
 
import 'package:redeo/widgets/app_button.dart';

class AddInviteePage extends StatefulWidget {
  const AddInviteePage({Key? key}) : super(key: key);

  @override
  State<AddInviteePage> createState() => _AddInviteePageState();
}

class _AddInviteePageState extends State<AddInviteePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Add Invitee',
          style: w600_16(color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              AppButton(
                  onPressedFunction: () {},
                  child: Text(
                    'Save',
                    style: w300_12(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invitee Name',
                    style: w300_13(
                      color: AppColors.blueColor,
                    ),
                  ),
                  TextFormField(
                    style: w300_14(),
                    decoration: InputDecoration(
                        hintStyle: w300_14(
                          color: AppColors.dark2GreyColor,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Name'),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: AppColors.greyColor),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Contacts',
                    style: w300_13(
                      color: AppColors.blueColor,
                    ),
                  ),
                  AppButton(
                      onPressedFunction: () {
                        Get.toNamed(Routes.inviteeScreen);
                      },
                      child: Text(
                        'Select',
                        // textSize: 12,
                        // fontWeight: FontWeight.bold,
                        style: w300_12(color: Colors.white),
                      ),
                      sodiumShapeBorder: true,
                      width: null,
                      height: 30.h,
                      buttonColor: AppColors.purpleColor)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

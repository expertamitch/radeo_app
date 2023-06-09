import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';

import 'package:redeo/widgets/app_button.dart';

import '../../../widgets/image_view.dart';

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
          style: w900_18(color: Colors.black),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                          style: w300_13(),
                          decoration: InputDecoration(
                              hintStyle: w300_13(),
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
                              style: w300_12(color: Colors.white),
                            ),
                            sodiumShapeBorder: true,
                            width: null,
                            height: 30.h,
                            buttonColor: AppColors.purpleColor)
                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              height: 45.h,
              width: double.maxFinite,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: AppColors.purpleColor),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.scanQrScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(
                        path: Images.qrCodeScanIcon,
                        color: Colors.white,
                        height: 23,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Scan QR code',
                        style: w900_14(color: Colors.white),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}

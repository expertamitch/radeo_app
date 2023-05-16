import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/styling/font_style_globle.dart';

import 'package:redeo/widgets/image_view.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';

import '../../get_controller/notice_of_event_controller.dart';
import 'package:redeo/widgets/app_button.dart';

class NoticeOfEventSummaryPage extends StatefulWidget {
  const NoticeOfEventSummaryPage({Key? key}) : super(key: key);

  @override
  State<NoticeOfEventSummaryPage> createState() =>
      _NoticeOfEventSummaryPageState();
}

class _NoticeOfEventSummaryPageState extends State<NoticeOfEventSummaryPage> {
  NoticeOfEventController controller = Get.find();
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
                  onPressedFunction: () {
                    Get.toNamed(Routes.createReturnPageScreen);
                  },
                  child: Text(
                    'Create Return',
                    style: w300_12(color: Colors.white),
                  ),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: null,
                  buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 10.w,
              ),
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.historyPage);
                  },
                  child: ImageView(
                    path: Images.historyIcon,
                    color: Colors.white,
                    height: 16,
                  ),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: null,
                  buttonColor: AppColors.blueColor)
            ],
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          controller.uploadImg!,
                          width: 100,
                          fit: BoxFit.cover,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        controller.nameController.text,
                        style: w600_14(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * .28,
                          height: 60,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: SvgPicture.asset(controller.level == 1
                              ? 'assets/icons/screen 18/Level 1.svg'
                              : controller.level == 2
                                  ? 'assets/icons/screen 18/Level 2.svg'
                                  : 'assets/icons/screen 18/Level 3.svg')),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Level',
                        style: w600_14(),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Indicators',
                    style: w600_12(),
                  ),
                  Text(
                    'Open for Encouragement',
                    style: w600_12(
                      color: AppColors.blueColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        controller.locationController.text,
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        controller.emailController.text,
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telephone',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        controller.telephoneController.text,
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date and Time',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        DateFormat('EEEE, MMM d, yyyy | h:mm a')
                            .format(controller.selectedDate!),
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Territory',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        controller.territoryController.text,
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        controller.locationController.text,
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attributes',
                    style: w600_12(),
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * .5).w,
                      child: Text(
                        '${controller.attributesStatus == 1 ? 'Single' : controller.attributesStatus == 2 ? 'Married' : 'Divorced'} | Boy: ${controller.boysController.text} | Girl : ${controller.girlsController.text} ',
                        textAlign: TextAlign.right,
                        style: w300_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(10),
                child: Text(
                  controller.noteController.text,
                  style: w300_12(color: AppColors.dark2GreyColor),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Attachment',
                    style: w600_12(),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Filename_23052023',
                            style: w300_12(),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          ImageView(
                            path: Images.closeIcon,
                            height: 10,
                            color: AppColors.purpleColor,
                          )
                        ],
                      ))
                ],
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

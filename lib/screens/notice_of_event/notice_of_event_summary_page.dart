import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../home/home_page_controller.dart';
import 'notice_of_event_controller.dart';

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
                  onPressedFunction: () async {
                    bool success = await controller.createNOE();
                    if (success) {
                      Get.back();
                      HomePageController homePageController = Get.find();
                      homePageController.currentSelectedIndex.value = 0;
                      homePageController.currentSelectedIndex.value = 1;
                      controller.reset();
                    }
                  },
                  child: Text(
                    'Save',
                    style: w300_12(color: Colors.white),
                  ),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: null,
                  buttonColor: AppColors.purpleColor),
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
                        child: controller.uploadImg != null
                            ? Image.file(
                                controller.uploadImg!,
                                width: 100,
                                fit: BoxFit.cover,
                                height: 60,
                              )
                            : ImageView(
                                path: Images.attachIcon,
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
              getDivider(),
              getCell('Location', controller.locationController.text),
              getDivider(),
              getCell('Email', controller.emailController.text),
              getDivider(),
              getCell('Telephone', controller.telephoneController.text),
              getDivider(),
              getCell(
                  'Date and Time',
                  controller.selectedDate != null
                      ? DateFormat('MMMM,dd yyyy, hh:mm a')
                          .format(controller.selectedDate!)
                      : "Sunday, January 5, 2021 | 12:05 pm"),
              getDivider(),
              getCell('Territory', controller.territoryInfo!.name!),
              getDivider(),
              getCell('Given Content Type ', controller.contentTypes),
              getDivider(),
              getCell(
                  'Given Content Name ', controller.contentNameController.text),
              getDivider(),
              getCell(
                  'Attributes',
                  '${controller.attributesStatus == 1 ? 'Single' : controller.attributesStatus == 2 ? 'Married' : 'Divorced'} | Boy: ${controller.boysController.text} | Girl : ${controller.girlsController.text} '),
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: DottedBorder(
                      color: AppColors.greyColor,
                      strokeWidth: 1,
                      dashPattern: [5, 5],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.attachmentFile!.split('/').last,
                              maxLines: 2,
                              style: w300_13(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              getDivider(),
              getCell(
                  'Return Visit',
                  controller.setReturnVisitDate != null
                      ? DateFormat('MMMM,dd yyyy, hh:mm a')
                          .format(controller.setReturnVisitDate!)
                      : "Sunday, January 5, 2021 | 12:05 pm"),
              getDivider(),
              getCell('Time Period', controller.selectedTimePeroidDD!),
              getDivider(),
              getCell('Notify Me', controller.selectedNotifyMeDD!),
              getDivider(),
              getCell('Notify ${controller.nameController.text}',
                  controller.notifySelf ? 'Yes' : 'No'),
              getDivider(),
              getCell('Indicators',
                  controller.indicatorsList[controller.indicatorStatus! - 1]),
              getDivider(),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDivider() {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Divider(thickness: 1, color: AppColors.borderGreyColor),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  getCell(String title, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: w600_12(),
        ),
        SizedBox(
            width: (MediaQuery.of(context).size.width * .4).w,
            child: Text(
              desc,

              textAlign: TextAlign.right,
              style: w300_13(),
            ))
      ],
    );
  }
}

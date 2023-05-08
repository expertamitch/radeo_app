import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../get_controller/notice_of_event_controller.dart';

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
              SizedBox(
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.createReturnPageScreen);
                    },
                    child: AppText(
                      text: 'Create Return',
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), primary: AppColors.blueColor),
                      onPressed: () {
                        Get.toNamed(Routes.historyPage);
                      },
                      child: ImageView(
                        path: Images.historyIcon,
                        color: Colors.white,
                        height: 18,
                      ))),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
                        height: 10,
                      ),
                      AppText(
                        text: controller.nameController.text,
                        textSize: 14,
                        fontWeight: FontWeight.bold,
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
                        height: 10,
                      ),
                      AppText(
                        text: 'Level',
                        textSize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Indicatores',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: 'Open for encouragement',
                    textSize: 14,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Location',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        controller.locationController.text,
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Email',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        controller.emailController.text,
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Telephone',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        controller.telephoneController.text,
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Date and Time',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        DateFormat('EEEE, MMM d, yyyy | h:mm a')
                            .format(controller.selectedDate!),
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Territory',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        controller.territoryController.text,
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Type',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        controller.locationController.text,
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Attributes',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        '${controller.attributesStatus == 1 ? 'Single' : controller.attributesStatus == 2 ? 'Married' : 'Divorced'} | Boy: ${controller.boysController.text} | Girl : ${controller.girlsController.text} ',
                        textAlign: TextAlign.right,
                        style: w500_13(),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(10),
                child: Text(
                  controller.noteController.text,
                  style: w400_12(color: AppColors.dark2GreyColor),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Attachment',
                    textSize: 14,
                    fontWeight: FontWeight.bold,
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
                            style: w400_12(),
                          ),
                          SizedBox(
                            width: 10,
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
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     AppText(
              //       text: 'Return Visit',
              //       textSize: 14,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     SizedBox(
              //         width: MediaQuery.of(context).size.width * .5,
              //         child: Text(
              //           DateFormat('EEEE, MMM d, yyyy | h:mm a')
              //               .format(controller.setReturnVisitDate!),
              //           textAlign: TextAlign.right,
              //           style: w500_13(),
              //         ))
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/network/repository/backend_repo.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../notice_of_event/notice_of_event_controller.dart';

class ReturnDetailScreen extends StatefulWidget {
  const ReturnDetailScreen({Key? key}) : super(key: key);

  @override
  State<ReturnDetailScreen> createState() => _ReturnDetailScreenState();
}

class _ReturnDetailScreenState extends State<ReturnDetailScreen> {
  NoticeOfEventController controller = Get.find();
  NOEModel model = Get.arguments;

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
                    Get.toNamed(Routes.createReturnPageScreen, arguments: model)
                        ?.then((value) {
                      if (value != null && value is NOEModel) model = value;
                      setState(() {});
                    });
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
                    Get.toNamed(Routes.historyPage, arguments: model);
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
                        child: Image.network(
                          model.nameImage!.startsWith('http')?model.nameImage!:BackendRepo.storageUrl + model.nameImage!,
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
                          child: SvgPicture.asset(
                              model.returnVisit!.level == 'cloud'
                                  ? 'assets/icons/screen 18/Level 1.svg'
                                  : model.returnVisit!.level == 'rain'
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
              getCell('Location', model.location!),
              getDivider(),
              getCell('Email', model.email!),
              getDivider(),
              getCell('Telephone', model.telephone??''),
              getDivider(),
              getCell('Date and Time',
                  DateFormat('MMMM,dd yyyy, hh:mm a').format(model.dateTime!)),
              getDivider(),
              getCell('Territory', model.territoryName!.toString()),
              getDivider(),
              getCell('Given Content Type ', model.givenContentType?.capitalize ?? ''),
              getDivider(),
              getCell('Given Content Name ', model.givenContentName ?? ''),
              getDivider(),
              getCell('Attributes', model.maritalStatus!.capitalize!),
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
                  model.notes!,
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
                    child: GestureDetector(
                      onTap: (){
                        launchUrl(Uri.parse(BackendRepo.storageUrl+model.attachments!),mode: LaunchMode.externalApplication);
                      },
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
                                model.attachments!,
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
                  ),
                ],
              ),
              getDivider(),
              getCell(
                  'Return Visit',
                  DateFormat('MMMM,dd yyyy, hh:mm a')
                      .format(model.returnVisit!.returnDate!)),
              getDivider(),
              getCell('Time Period', model.returnVisit!.type=='month'?'Monthly':model.returnVisit!.type=='year'?'Yearly':model.returnVisit!.type=='week'?'Weekly':model.returnVisit!.type!),
              getDivider(),
              getCell('Notify Me', model.returnVisit!.notificationSelf=='month'?'Monthly':model.returnVisit!.notificationSelf=='year'?'Yearly':model.returnVisit!.notificationSelf=='week'?'Weekly':model.returnVisit!.notificationSelf!),
              getDivider(),
              getCell('Notify ${model.name!}',
                  !model.returnVisit!.notificationOther! ? 'Yes' : 'No'),
              getDivider(),
              getCell('Indicators', model.indicators=='open-for-encourgament'?'Open for Encouragement':'Do Not Contact'),
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
        
        Expanded(
          child: Text(
            desc,
            textAlign: TextAlign.right,
            style: w300_13(),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../../assets/images.dart';
import '../../../models/create_message_request_model.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/image_view.dart';
import '../../home/home_page_controller.dart';

class ReviewMessagePage extends StatefulWidget {
  const ReviewMessagePage({Key? key}) : super(key: key);

  @override
  State<ReviewMessagePage> createState() => _ReviewMessagePageState();
}

class _ReviewMessagePageState extends State<ReviewMessagePage> {
  MessageController controller = Get.find();

  CreateMessageRequestModel model = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                AppButton(
                    onPressedFunction: () async {
                      var success = await controller.createMessage(model);
                      if (success) {
                        Get.back();
                        HomePageController homePageController = Get.find();
                        homePageController.currentSelectedIndex.value = 1;
                        homePageController.currentSelectedIndex.value = 2;
                        controller.reset();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: w300_12(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Review Message',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'QR Code',
                style: w300_13(
                  color: AppColors.blueColor,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: PrettyQr(
                // image: AssetImage('images/twitter.png'),
                typeNumber: 3,
                size: 120,
                data: 'https://www.google.ru',
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${model.selectedMessageType} Message',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (model.selectedMessageType == 'Text')
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.lightGreyColor),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.textMessageList.value
                                        .lastWhere((element) =>
                                            element.id ==
                                            model.selectedMessageId)
                                        .content ??
                                    '',
                                style: w300_13(color: AppColors.dark2GreyColor),
                              ),
                            ),
                          ],
                        )),
                  if (model.selectedMessageType == 'Audio')
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightGreyColor),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Images.audiFileIcon,
                            width: 30,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.audioMessageList.value
                                        .lastWhere((element) =>
                                            element.id ==
                                            model.selectedMessageId)
                                        .title ??
                                    '',
                                style: w300_13(),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 5,
                          )),
                        ],
                      ),
                    ),
                  if (model.selectedMessageType == 'Video')
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.lightGreyColor),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          ImageView(
                            path: (controller.videoMessageList.value
                                    .lastWhere((element) =>
                                        element.id == model.selectedMessageId)
                                    .thumbnail ??
                                ''),
                            height: 50,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.videoMessageList.value
                                        .lastWhere((element) =>
                                            element.id ==
                                            model.selectedMessageId)
                                        .title ??
                                    '',
                                style: w300_13(),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 5,
                          )),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Location',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      ImageView(
                        path: Images.locationIcon,
                        color: AppColors.purpleColor,
                        height: 18,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Text(
                          model.location,
                          style: w300_13(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            if (model.response)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Response:',
                            style: w300_13(
                              color: AppColors.blueColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(model.selectedResponseType!,
                              style: w300_13(
                                color: AppColors.purpleColor,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (model.selectedResponseType == 'Custom')
                      Column(
                        children: model.selectedCustomResponseId
                            .map(
                              (e) => Column(children: [Row(
                                children: [
                                  CircleAvatar(
                                    radius: 7,
                                    backgroundColor: AppColors.purpleColor,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    controller.customMessageList.value
                                        .lastWhere((element) => element.id == e)
                                        .content!,
                                    style: w300_13(),
                                  ),
                                ],
                              ), SizedBox(height: 8.h,)],),
                            )
                            .toList(),
                      )
                  ],
                ),
              ),
          ])))
        ]));
  }
}

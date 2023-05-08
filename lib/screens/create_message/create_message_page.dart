import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/app_text.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../get_controller/create_messages_controller.dart';

import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/colors.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  bool response = false;

  CreateMessagesController getController = Get.put(CreateMessagesController());
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
              SizedBox(
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.reviewMessageScreen);
                    },
                    child: AppText(
                      text: 'Review',
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(children: [
        Container(
          width: double.maxFinite,
          color: AppColors.darkGreyColor,
          padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
          child: AppText(
            text: 'Create Message',
            textSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: 'Location',
                    textSize: 14,
                    color: AppColors.blueColor,
                  ),
                  TextFormField(
                    style: w500_14(),
                    decoration: InputDecoration(
                        labelStyle: w500_14(
                          color: AppColors.dark2GreyColor,
                        ),
                        hintText: 'Select Location',
                        border: InputBorder.none,
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: 20, minWidth: 20),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView(
                                path: Images.locationIcon,
                                color: AppColors.purpleColor,
                                height: 18,
                              ),
                            ],
                          ),
                        )),
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: 'Select Message',
                    textSize: 14,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getController.selectedMessageType = 'Text';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: getController.selectedMessageType ==
                                          'Text'
                                      ? AppColors.purpleColor
                                      : AppColors.greyColor),
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView(
                                path: Images.textFileIcon,
                                height: 16,
                                color: AppColors.purpleColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: 'Text',
                                color:
                                    getController.selectedMessageType == 'Text'
                                        ? AppColors.purpleColor
                                        : Colors.black,
                                textSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getController.selectedMessageType = 'Audio';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: getController.selectedMessageType ==
                                          'Audio'
                                      ? AppColors.purpleColor
                                      : AppColors.greyColor),
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView(
                                path: Images.audioIcon,
                                height: 16,
                                color: AppColors.purpleColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: 'Audio',
                                textSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    getController.selectedMessageType == 'Audio'
                                        ? AppColors.purpleColor
                                        : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getController.selectedMessageType = 'Video';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: getController.selectedMessageType ==
                                          'Video'
                                      ? AppColors.purpleColor
                                      : AppColors.greyColor),
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView(
                                path: Images.videoIcon,
                                height: 16,
                                color: AppColors.purpleColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: 'Video',
                                textSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    getController.selectedMessageType == 'Video'
                                        ? AppColors.purpleColor
                                        : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: 'Attachment',
                    textSize: 14,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getAttachment(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Response',
                        textSize: 14,
                        color: AppColors.blueColor,
                      ),
                      Transform.scale(
                        scale: 0.6,
                        child: CupertinoSwitch(
                          activeColor: AppColors.purpleColor,
                          value: response,
                          onChanged: (value) {
                            setState(() {
                              response = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  if (response) getResponseWidget(),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: 'Associating QR Code',
                    textSize: 14,
                    color: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: PrettyQr(
                      // image: AssetImage('images/twitter.png'),
                      typeNumber: 3,
                      size: 130,
                      data: 'https://www.google.ru',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  getResponseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  getController.selectedResponseType = 'Open';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: getController.selectedResponseType == 'Open'
                            ? AppColors.purpleColor
                            : AppColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                alignment: Alignment.center,
                child: AppText(
                  text: 'Open',
                  textSize: 16,
                  color: getController.selectedResponseType == 'Open'
                      ? AppColors.purpleColor
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  getController.selectedResponseType = 'Custom';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: getController.selectedResponseType == 'Custom'
                            ? AppColors.purpleColor
                            : AppColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                alignment: Alignment.center,
                child: AppText(
                  text: 'Custom',
                  color: getController.selectedResponseType == 'Custom'
                      ? AppColors.purpleColor
                      : Colors.black,
                  textSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        for (var r in getController.selectedResponseList) responseListTile(r),
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: TextButton(
              onPressed: () {},
              child: AppText(
                text: '+ Add New',
                textSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.purpleColor,
              )),
        )
      ],
    );
  }

  responseListTile(Map<String, dynamic> r) {
    return Row(
      children: [
        Checkbox(
          value: r['isSelected'],
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (!states.contains(MaterialState.selected)) {
              return AppColors.dark2GreyColor;
            }

            return AppColors.purpleColor;
          }),
          onChanged: (value) {
            r['isSelected'] = value;
            int currentResIndex = getController.selectedResponseList.indexOf(r);
            setState(() {
              getController.selectedResponseList[currentResIndex] = r;
            });
          },
        ),
        Flexible(
          child: Text(
            r['title'],
            style: w500_14(),
          ),
        )
      ],
    );
  }

  getAttachment() {
    return GestureDetector(
      onTap: () {
        if (getController.selectedMessageType == 'Text') {
          Get.toNamed(Routes.selectTextMessageScreen);
        } else if (getController.selectedMessageType == 'Audio') {
          Get.toNamed(Routes.selectAudioMessageScreen);
        } else {
          Get.toNamed(Routes.selectVideoMessageScreen);
        }
      },
      child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ImageView(path: Images.selectFiles)),
    );
  }
}

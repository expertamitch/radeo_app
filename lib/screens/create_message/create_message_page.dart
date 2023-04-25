import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/create_message/select%20message/select_audio_message_page.dart';
import 'package:redeo/screens/create_message/select%20message/select_text_message_page.dart';
import 'package:redeo/screens/create_message/select%20message/select_video_message_page.dart';

import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/app_text.dart';
import 'package:redeo/widgets/image_view.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  String? selectedMessageType; //Text, Audio, Video
  bool response = false;
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
                    onPressed: () {},
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
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
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
                    color: AppColors.lighBlueColor,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Select Location',
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView(
                              path: Images.locationIcon,
                              height: 18,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppText(
                    text: 'Select Message',
                    textSize: 14,
                    color: AppColors.lighBlueColor,
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
                            selectedMessageType = 'Text';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedMessageType == 'Text'
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
                                textSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMessageType = 'Audio';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedMessageType == 'Audio'
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
                                textSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMessageType = 'Video';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedMessageType == 'Video'
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
                                textSize: 16,
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
                    color: AppColors.lighBlueColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        if (selectedMessageType == 'Text') {
                          Get.to(SelectTextMessagePage());
                        } else if (selectedMessageType == 'Audio') {
                          Get.to(SelectAudioMessage());
                        } else {
                          Get.to(SelectVideoMessagePage());
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          primary: AppColors.purpleColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageView(
                            path: Images.attachIcon,
                            height: 16,
                            color: AppColors.purpleColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AppText(
                            text: 'Select Files',
                            textSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        color: AppColors.lighBlueColor,
                      ),
                      Transform.scale(
                        scale: 0.6,
                        child: CupertinoSwitch(
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
                    color: AppColors.lighBlueColor,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: PrettyQr(
                      // image: AssetImage('images/twitter.png'),
                      typeNumber: 3,
                      size: 150,
                      data: 'https://www.google.ru',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../assets/images.dart';
import '../../../get_controller/create_messages_controller.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/image_view.dart';

class ReviewMessagePage extends StatefulWidget {
  const ReviewMessagePage({Key? key}) : super(key: key);

  @override
  State<ReviewMessagePage> createState() => _ReviewMessagePageState();
}

class _ReviewMessagePageState extends State<ReviewMessagePage> {
  CreateMessagesController getController = Get.find();
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
                          shape: StadiumBorder(),
                          primary: AppColors.purpleColor),
                      onPressed: () {},
                      child: AppText(
                        text: 'Submit',
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
              text: 'Review Message',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(children: [
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: AppText(
                            text: 'QR Code',
                            textSize: 14,
                            color: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: PrettyQr(
                            // image: AssetImage('images/twitter.png'),
                            typeNumber: 3,
                            size: 100,
                            data: 'https://www.google.ru',
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Video Message',
                            textSize: 14,
                            color: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset('assets/dummy_data/video_tile.png'),
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Location',
                            textSize: 14,
                            color: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ImageView(
                              path: Images.locationIcon,
                              color: AppColors.purpleColor,
                              height: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              text:
                                  '2006 Chapmans Lane, San Francisco, California…',
                              textSize: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              AppText(
                                text: 'Response:',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              AppText(
                                text: 'Custom',
                                textSize: 14,
                                color: AppColors.purpleColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: AppColors.purpleColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              text: 'The info was helpful, Thanks',
                              textSize: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: AppColors.purpleColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              text: 'The info was helpful, Send more',
                              textSize: 14,
                            ),
                          ],
                        )
                      ]))))
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../../assets/images.dart';
import '../../../get_controller/create_messages_controller.dart';
import '../../../styling/app_colors.dart';

import '../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

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
                AppButton(
                    onPressedFunction: () {},
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
                      'Video Message',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.lightGreyColor),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        ImageView(
                          path: 'assets/dummy_data/video 02.png',
                          height: 50,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'vidofile_23052023',
                              style: w300_13(),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '00:12',
                                  style:
                                      w300_10(color: AppColors.dark2GreyColor),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '12 KB',
                                  style:
                                      w300_10(color: AppColors.dark2GreyColor),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
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
                          '2006 Chapmans Lane, San Francisco, California',
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
                        Text('Custom',
                            style: w300_13(
                              color: AppColors.purpleColor,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: AppColors.purpleColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'The info was helpful, Thanks',
                        style: w300_13(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: AppColors.purpleColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'The info was helpful, Send more',
                        style: w300_13(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ])))
        ]));
  }
}

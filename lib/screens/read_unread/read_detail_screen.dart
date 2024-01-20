import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../models/read_unread_list_model.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class ReadDetailScreen extends StatefulWidget {
  @override
  _ReadDetailScreenState createState() => _ReadDetailScreenState();
}

class _ReadDetailScreenState extends State<ReadDetailScreen> {
  ReadUnreadMessageModel model = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Center(
              child: Column(children: [
                SizedBox(
                  height: 30,
                ),
                ImageView(
                  path: Images.icLocation,
                  width: 70,
                  height: 70,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  model.location ?? '',
                  style: w600_13(color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    DateFormat('dd MMM yyyy, HH:mm a').format(model.updatedAt!),
                    style: w300_11(
                      color: Color(0XFF8E8E8E),
                    )),
              ]),
            ),
            SizedBox(
              height: 26,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0XFFEFEFEF),
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Your Message',
                    style: w300_12(color: Color(0XFF73BAD9)),
                  ),
                  Spacer(),  ImageView(
                    path: model.isRead == 1
                        ? Images.icReadCheck
                        : Images.icUnreadCheck,
                    width: 26,
                  ),
                  SizedBox(
                      width: 10,
                  ),
                  Text(
                    model.isRead == 1 ? 'Read' : 'Unread',
                    style: w300_11(
                        color: model.isRead == 1
                            ? Color(0XFF74167B)
                            : Color(0XFF8E8E8E)),
                  )

                ],
              ),
            )
          ],
        ));
  }
}

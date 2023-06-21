import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/screens/create_message/text_message/show_text_message_sheet.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../../../assets/images.dart';
import '../../../../get_controller/create_messages_controller.dart';
import '../../../../styling/app_colors.dart';

import '../../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

class EnterTextMessagePage extends StatefulWidget {
  const EnterTextMessagePage({Key? key}) : super(key: key);

  @override
  State<EnterTextMessagePage> createState() => _EnterTextMessagePageState();
}

class _EnterTextMessagePageState extends State<EnterTextMessagePage> {
  CreateMessagesController getController = Get.find();
  TextEditingController textMessageController = TextEditingController();

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
                    onPressedFunction: () {
                      showTextMessageBottomSheet(textMessageController.text);
                    },
                    child: Text(
                      'Next',
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
              'Enter Text',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Flexible(
                        child: TextFormField(
                      style: w300_14(),
                      controller: textMessageController,
                      decoration: InputDecoration(
                          hintStyle: w300_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                          hintText: 'Enter your text here...',
                          border: InputBorder.none),
                      maxLines: 99,
                    )),
                  ),
                ],
              ),
            ),
          ])))
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/styling/app_colors.dart';

import '../../../styling/font_style_globle.dart';
import '../../../widgets/app_button.dart';

class CreateCustomMessage extends StatefulWidget {
  @override
  _CreateCustomMessageState createState() => _CreateCustomMessageState();
}

class _CreateCustomMessageState extends State<CreateCustomMessage> {
  MessageController controller = Get.find();
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
                    onPressedFunction: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      var success = await controller
                          .saveCustomMessage(textMessageController.text);
                      if (success) Get.back();
                    },
                    child: Text(
                      'Save',
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
              'Create custom message',
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
                    child: TextFormField(
                      style: w300_14(),
                      controller: textMessageController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintStyle: w300_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                          hintText: 'Enter your text here...',
                          border: InputBorder.none),
                      maxLines: 99,
                    ),
                  ),
                ],
              ),
            ),
          ])))
        ]));
  }
}

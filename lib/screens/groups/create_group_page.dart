import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/colors.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
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
                          shape: StadiumBorder(),
                          primary: AppColors.purpleColor),
                      onPressed: () {},
                      child: AppText(
                        text: 'Save',
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: AppText(
              text: 'Create Group',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppText(
            text: 'Group Name',
            padding: EdgeInsets.only(left: 18),
            textSize: 15,
            color: AppColors.blueColor,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              style: w300_14(),
              decoration: InputDecoration(
                  hintStyle: w300_14(
                    color: AppColors.dark2GreyColor,
                  ),
                  hintText: 'Group Name',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppText(
                text: 'Select Member',
                padding: EdgeInsets.only(left: 18),
                textSize: 15,
                color: AppColors.blueColor,
              ),
              Expanded(
                child: SizedBox(
                  width: 18,
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.inviteeScreen);
                    },
                    child: AppText(
                      text: 'Select',
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                width: 18,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppText(
                text: 'Select Attendants',
                padding: EdgeInsets.only(left: 18),
                textSize: 15,
                color: AppColors.blueColor,
              ),
              Expanded(
                child: SizedBox(
                  width: 18,
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.attendantsScreen);
                    },
                    child: AppText(
                      text: 'Select',
                      textSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                width: 18,
              ),
            ],
          )
        ]));
  }
}

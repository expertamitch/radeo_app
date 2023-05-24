import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/common_app_bar.dart';

import '../../../styling/app_colors.dart';
import 'tabs/contact_tab_page.dart';
import 'tabs/redeo_tab_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String contactType = 'Contact'; // Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: 'Contacts',
            isBack: true,
            button1: 'Done',
            buttonTap1: () {
              Get.back();
            }),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.lightBlueColor),
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      contactType = 'Contact';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: contactType != 'Contact'
                          ? AppColors.lightBlueColor
                          : AppColors.blueColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Contact',
                      style: w600_14(
                        color: contactType == 'Contact'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      contactType = 'Redeo';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: contactType != 'Redeo'
                          ? AppColors.lightBlueColor
                          : AppColors.blueColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Redeo',
                      style: w600_14(
                        color: contactType == 'Redeo'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (contactType == 'Contact') ContactTabPage(),
          if (contactType == 'Redeo') RedeoTabPage(),
          SizedBox(
            height: 10.h,
          ),
        ]));
  }
}

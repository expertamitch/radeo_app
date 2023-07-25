import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/common_app_bar.dart';

import '../../../styling/app_colors.dart';
import '../controller/contacts_controller.dart';
import 'tabs/assign_contact_tab_page.dart';
import 'tabs/assign_redeo_tab_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactsController controller = Get.put(ContactsController());

  check() {
    if (keepChecking) {
      bool selected = false;

      controller.tempRedeoList.forEach((element) {
        if (element.selected) {
          selected = true;
        }
      });

      controller.contacts.forEach((element) {
        if (element.selected) {
          selected = true;
        }
      });

      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        isValid.value = (selected);
        setState(() {});
        check();
      });
    }
  }

  RxBool isValid = false.obs;
  bool keepChecking = true;

  @override
  void initState() {
    check();
    super.initState();
  }

  String contactType = 'Redeo'; //Group, Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: 'Assign territory',
            isBack: true,
            button1: 'Done',
            button1Disabled: !isValid.value,
            buttonTap1: () {
              if (isValid.value) {
                String id='';
                controller.tempRedeoList.forEach((element) {
                  if (element.selected) {
                    id= element.id.toString();
                  }
                });



                Get.back( result: id);
              }

            }),
        body: Column(children: [
          /*SizedBox(
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
          ),*/
          SizedBox(
            height: 10.h,
          ),
          // if (contactType == 'Contact') AssignContactTabPage(),
          if (contactType == 'Redeo') AssignRedeoTabPage(),
          SizedBox(
            height: 10.h,
          ),
        ])));
  }

  @override
  void dispose() {
    keepChecking = false;
    super.dispose();
  }
}

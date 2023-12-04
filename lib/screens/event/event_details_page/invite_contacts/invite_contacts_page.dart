import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/widgets/common_app_bar.dart';

import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../invite/controller/invite_controller.dart';
import '../../../territory/controller/contacts_controller.dart';
import 'tabs/invite_contact_tab_page.dart';
import 'tabs/invite_redeo_tab_page.dart';

class InviteContactsPage extends StatefulWidget {
  const InviteContactsPage({Key? key}) : super(key: key);

  @override
  State<InviteContactsPage> createState() => _InviteContactsPageState();
}

class _InviteContactsPageState extends State<InviteContactsPage> {
  // ContactsController controller = Get.put(ContactsController());
  InviteController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  String contactType = 'Contact'; //Group, Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: 'Invitee',
            isBack: true,
            button1: 'Done',
            backPress: () {
              Get.back();
            },
            buttonTap1: () {
              controller.selectedMembersCount.value = 0;
              String id = '';
              controller.tempRedeoList.forEach((element) {
                if (element.selected) {
                  Get.back(
                      result: UserData(
                          contact_type: 'redeo',
                          firstName: element.firstName,
                          lastName: element.lastName,
                          name: element.fullName,
                          mobile: element.mobile));
                  id = element.id.toString();
                  controller.selectedMembersCount++;
                }
              });
              controller.tempContactsList.forEach((element) {
                if (element.selected) {
                  Get.back(
                      result: UserData(
                          contact_type: 'phone',
                          firstName: element.phoneContact.name.first,
                          lastName: element.phoneContact.name.last,
                          name:
                              "${element.phoneContact.name.first} ${element.phoneContact.name.last}",
                          mobile: element.phoneContact.phones[0].number));

                  controller.selectedMembersCount++;
                }
              });

 
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
          if (contactType == 'Contact') InviteContactTabPage(),
          if (contactType == 'Redeo') InviteRedeoTabPage(),
          SizedBox(
            height: 10.h,
          ),
        ]));
  }
}

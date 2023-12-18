import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_contact/existing_contacts/tabs/redeo_tab_page.dart';
import 'package:redeo/widgets/common_app_bar.dart';

import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../route/routes.dart';
import '../add_contact_controller.dart';
import 'tabs/contact_tab_page.dart';

class ExistingContactsPage extends StatefulWidget {
  const ExistingContactsPage({Key? key}) : super(key: key);

  @override
  State<ExistingContactsPage> createState() => _ExistingContactsPageState();
}

class _ExistingContactsPageState extends State<ExistingContactsPage> {
  AddContactController controller = Get.put(AddContactController());

  @override
  void initState() {
    super.initState();
  }

  String contactType = 'Contact'; //   Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Contacts',
          button1: 'Add Contact',
          buttonTap1: () async {
            await Get.toNamed(Routes.addNewContactManually);
            controller.getAllRedeoMemberList();
          },
        ),
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

import 'package:flutter/material.dart';
import 'package:redeo/screens/event/invitee/tabs/contact_tab_page.dart';
import 'package:redeo/screens/event/invitee/tabs/redeo_tab_page.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/app_text.dart';
import 'tabs/group_tab_page.dart';

class InviteePage extends StatefulWidget {
  const InviteePage({Key? key}) : super(key: key);

  @override
  State<InviteePage> createState() => _InviteePageState();
}

class _InviteePageState extends State<InviteePage> {
  String contactType = 'Group'; //Group, Contact, Redeo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: AppText(
            text: 'Invitee',
            textSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
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
                      contactType = 'Group';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: contactType != 'Group'
                          ? AppColors.lightBlueColor
                          : AppColors.blueColor,
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: 'Group',
                      textSize: 16,
                      color:
                          contactType == 'Group' ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
                    child: AppText(
                      text: 'Contact',
                      textSize: 16,
                      color: contactType == 'Contact'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
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
                    child: AppText(
                      text: 'Redeo',
                      textSize: 16,
                      color:
                          contactType == 'Redeo' ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          if (contactType == 'Group') GroupTabPage(),
          if (contactType == 'Contact') ContactTabPage(),
          if (contactType == 'Redeo') RedeoTabPage(),
          SizedBox(
            height: 10,
          ),
        ]));
  }
}

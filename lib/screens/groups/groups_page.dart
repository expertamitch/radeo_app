import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/app_colors.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
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
                AppButton(
                    onPressedFunction: () {
                      Get.toNamed(Routes.createGroupScreen);
                    },
                    child: Text(
                      'Create Group',
                      style: w500_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
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
              'Groups',
              style: w700_30(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                ImageView(
                  path: Images.searchIcon,
                  color: Colors.purple,
                ),
                SizedBox(width: 15.w),
                Flexible(
                    child: TextFormField(
                  style: w500_14(),
                  decoration: InputDecoration(
                      hintStyle: w500_14(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Groups…',
                      isDense: true),
                ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return groupListTile(
                      title: 'Group Name A',
                      subtitle: '34 Members',
                    );
                  }))
        ]));
  }

  groupListTile({
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          child: Row(
            children: [
              SvgPicture.asset(
                Images.groupPeopleIcon,
                height: 25,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: w500_14(),
                  ),
                  Text(
                    subtitle,
                    style: w500_12(color: Colors.grey),
                  ),
                ],
              ),
              Expanded(
                  child: SizedBox(
                width: 10.w,
              )),
              Row(
                children: [
                  // Icon(Icons.edit),
                  ImageView(
                    path: Images.editIcon,
                    height: 15,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  ImageView(
                    path: Images.deleteIcon,
                    height: 15,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

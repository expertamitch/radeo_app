import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/app_colors.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

import '../../widgets/common_app_bar.dart';
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
        appBar:CustomAppBar(
          title: 'Groups',
          button1: 'Create Group',
           buttonTap1: () {
             Get.toNamed(Routes.createGroupScreen);
          },

        ),

         body: Column(children: [
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
                  style: w300_12(),
                  decoration: InputDecoration(
                      hintStyle: w300_12(
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
                height: 23.h,
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
                    style: w300_12(),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    subtitle,
                    style: w300_10(color: Colors.grey),
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

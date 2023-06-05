import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/images.dart';
import '../../models/all_group_list_response_model.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/common_dialogs.dart';
import '../image_view.dart';

class GroupTile extends StatelessWidget{
  Group groupModel;

  GroupTile({required this.groupModel});
  @override
  Widget build(BuildContext context) {
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
                    groupModel.groupName??'',
                    overflow: TextOverflow.ellipsis,
                    style: w300_12(),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      "${groupModel.groupUsersCount} Members",
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
                  GestureDetector(
                    onTap: () {
                      showDeleteConfirmation(
                          context, "Do you want to delete group?");
                    },
                    child: ImageView(
                      path: Images.deleteIcon,
                      height: 15.h,
                    ),
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
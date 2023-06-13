import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/radio_selection_widget.dart';

import '../../assets/images.dart';
import '../../models/all_group_list_response_model.dart';
import '../../screens/groups/controller/groups_controller.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/common_dialogs.dart';
import '../image_view.dart';

class GroupTile extends StatelessWidget {
  GroupModel groupModel;
  VoidCallback? onTap;

  //if true, then this is from groups otherwise it is from invites
  bool isList = false;

  GroupTile({
    required this.groupModel,
    required this.isList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () {},
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
                    groupModel.groupName ?? '',
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
              isList
                  ? Row(
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
                                context, "Do you want to delete group?",yesCallback: () async {
                              GroupsController groupsController=Get.find();
                              Map<String,dynamic> data={};
                              data["group_id"]=groupModel.id!.toString();
                              var success = await groupsController.deleteGroup(data);
                              if (success) {
                                groupsController.getGroupsList();
                                Navigator.of(context).pop();
                              }
                            });
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
                  : Row(
                    children: [
                      RadioSelectionWidget(selected: groupModel.selected),
                      SizedBox(width: 18.w,)


                    ],
                  )
            ],
          ),
        ));
  }
}

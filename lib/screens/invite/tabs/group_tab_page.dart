import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/image_view.dart';
import '../../../widgets/not_found_widget.dart';
import '../../../widgets/on_screen_loader.dart';
import '../../../widgets/tiles/group_tile.dart';
import '../controller/invite_controller.dart';

class GroupTabPage extends StatefulWidget {
  const GroupTabPage({Key? key}) : super(key: key);

  @override
  State<GroupTabPage> createState() => _GroupTabPageState();
}

class _GroupTabPageState extends State<GroupTabPage> {
  InviteController inviteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => inviteController.groupsListLoading.value
          ? OnScreenLoader()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${inviteController.groupsList.value.length} Groups',
                        style: w900_15(),
                      ),
                      GestureDetector(
                        onTap: () {
                          inviteController.groupsList.forEach((element) {
                            element.selected = true;
                          });
                          setState(() {});
                        },
                        child: Text(
                          'Select All',
                          style: w600_14(color: AppColors.purpleColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius: BorderRadius.circular(8)),
                  // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                            border: InputBorder.none,
                            hintStyle: w300_12(
                              color: AppColors.dark2GreyColor,
                            ),
                            hintText: 'Search Group...',
                            isDense: true),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Obx(() => inviteController.groupsList.value.isEmpty
                      ? NotFoundWidget(
                          title: 'No groups found',
                        )
                      : ListView.builder(
                          itemCount: inviteController.groupsList.value.length,
                          itemBuilder: (context, index) {
                            return GroupTile(
                              groupModel:
                                  inviteController.groupsList.value[index],
                              isList: false,
                              onTap: () {
                                inviteController
                                        .groupsList.value[index].selected =
                                    !inviteController
                                        .groupsList.value[index].selected;

                                inviteController.refreshCount();

                                setState(() {});
                              },
                            );
                          })),
                )
              ],
            )),
    );
  }
}

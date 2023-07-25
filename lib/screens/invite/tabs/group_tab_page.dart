import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';

import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
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
                        '${inviteController.tempGroupsList.value.length} Groups',
                        style: w900_15(),
                      ),
                      GestureDetector(
                        onTap: () {
                          inviteController.tempGroupsList.forEach((element) {
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
                SearchWidget(hint: 'Search Group...', onChange: inviteController.executeGroupSearch),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Obx(() => inviteController.tempGroupsList.value.isEmpty
                      ? Center(
                        child: SingleChildScrollView(
                          child: NotFoundWidget(
                              title: 'No groups found',
                            ),
                        ),
                      )
                      : ListView.builder(
                          itemCount: inviteController.tempGroupsList.value.length,
                          itemBuilder: (context, index) {
                            return GroupTile(
                              groupModel:
                                  inviteController.tempGroupsList.value[index],
                              isList: false,
                              onTap: () {
                                inviteController
                                        .tempGroupsList.value[index].selected =
                                    !inviteController
                                        .tempGroupsList.value[index].selected;

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

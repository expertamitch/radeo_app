import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/groups/controller/groups_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/not_found_widget.dart';
import 'package:redeo/widgets/on_screen_loader.dart';
import 'package:redeo/widgets/tiles/group_tile.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/image_view.dart';
import '../invite/controller/invite_controller.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  GroupsController controller = Get.find();

  @override
  void initState() {
    controller.getGroupsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
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
            child: Obx(() => controller.groupsListLoading.value
                ? OnScreenLoader()
                : controller.groupsList.value.isEmpty
                    ? NotFoundWidget(
                        title: 'No groups found',
                      )
                    : ListView.builder(
                        itemCount: controller.groupsList.value.length,
                        itemBuilder: (context, index) {
                          return GroupTile(
                            groupModel: controller.groupsList.value[index],
                            isList: true,
                          );
                        })),
          )
        ]));
  }
}

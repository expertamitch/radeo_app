import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/groups/controller/groups_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/not_found_widget.dart';
import 'package:redeo/widgets/on_screen_loader.dart';
import 'package:redeo/widgets/search_widget.dart';
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

          SearchWidget(hint: 'Search Groups…', onChange: (data){
controller.executeSearch(data);
          }),

          Expanded(
            child: Obx(() => controller.groupsListLoading.value
                ? OnScreenLoader()
                : controller.tempGroupsList.isEmpty
                    ? NotFoundWidget(
                        title: 'No groups found',
                      )
                    : ListView.builder(
                        itemCount: controller.tempGroupsList.length,
                        itemBuilder: (context, index) {
                          return GroupTile(
                            groupModel: controller.tempGroupsList[index],
                            isList: true,
                            onTap: (){
                              controller.tempGroupsList[index].isEditing=false;
                              Get.toNamed(Routes.editGroupScreen, arguments: controller.tempGroupsList[index]);
                            },
                          );
                        })),
          )
        ]));
  }
}

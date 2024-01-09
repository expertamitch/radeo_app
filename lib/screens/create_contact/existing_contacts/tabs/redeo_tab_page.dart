import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/redeo_tile.dart';

import '../../../../../styling/font_style_globle.dart';
import '../../../../../widgets/not_found_widget.dart';
import '../../../../../widgets/on_screen_loader.dart';
import '../../../../route/routes.dart';
import '../../add_contact_controller.dart';

class RedeoTabPage extends StatefulWidget {
  const RedeoTabPage({Key? key}) : super(key: key);

  @override
  State<RedeoTabPage> createState() => _InviteRedeoTabPageState();
}

class _InviteRedeoTabPageState extends State<RedeoTabPage> {
  // ContactsController controller = Get.find();
  AddContactController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => controller.redeoListLoading.value
          ? OnScreenLoader()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${controller.tempRedeoList.value.length} Redeo Contact',
                        style: w900_15(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SearchWidget(
                    hint: 'Search Redeo Contact',
                    onChange: controller.executeRedeoSearch),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                    child: Obx(
                  () => controller.tempRedeoList.value.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: NotFoundWidget(
                              title: 'No Redeo contacts found',
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.tempRedeoList.value.length,
                          itemBuilder: (context, index) {
                            return RedeoTile(
                              model: controller.tempRedeoList.value[index],
                              showEditButton: true,
                              onEditTap: () async {
                                await Get.toNamed(Routes.addEditContactManually,
                                    arguments:
                                    controller.tempRedeoList.value[index]);
                                controller.getAllRedeoMemberList();

                              },
                              showRadioButton: false,

                            );
                          },
                        ),
                ))
              ],
            ),
    ));
  }
}

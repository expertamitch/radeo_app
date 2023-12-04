import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/redeo_tile.dart';

import '../../../../../styling/font_style_globle.dart';
import '../../../../../widgets/not_found_widget.dart';
import '../../../../../widgets/on_screen_loader.dart';
import '../../../../invite/controller/invite_controller.dart';
import '../../../../territory/controller/contacts_controller.dart';

class InviteRedeoTabPage extends StatefulWidget {
  const InviteRedeoTabPage({Key? key}) : super(key: key);

  @override
  State<InviteRedeoTabPage> createState() => _InviteRedeoTabPageState();
}

class _InviteRedeoTabPageState extends State<InviteRedeoTabPage> {
  // ContactsController controller = Get.find();
  InviteController controller = Get.find();

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
                              onTap: () {
                                for (int i = 0;
                                    i < controller.tempRedeoList.value.length;
                                    i++) {
                                  if (i != index)
                                    controller.tempRedeoList.value[i].selected =
                                        false;
                                }
                                controller.tempRedeoList.value[index].selected =
                                    !controller
                                        .tempRedeoList.value[index].selected;

                                controller.tempContactsList.forEach((element) {
                                  element.selected = false;
                                });

                                setState(() {});
                              },
                            );
                          },
                        ),
                ))
              ],
            ),
    ));
  }
}

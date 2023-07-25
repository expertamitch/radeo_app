import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/redeo_tile.dart';
import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/not_found_widget.dart';
import '../../../../widgets/on_screen_loader.dart';
import '../../controller/contacts_controller.dart';

class AssignRedeoTabPage extends StatefulWidget {
  const AssignRedeoTabPage({Key? key}) : super(key: key);

  @override
  State<AssignRedeoTabPage> createState() => _AssignRedeoTabPageState();
}

class _AssignRedeoTabPageState extends State<AssignRedeoTabPage> {
  ContactsController controller = Get.find();

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
                 SearchWidget(hint: 'Search Redeo Contact', onChange: controller.executeSearch),
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

                                controller.contacts.value.forEach((element) {
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

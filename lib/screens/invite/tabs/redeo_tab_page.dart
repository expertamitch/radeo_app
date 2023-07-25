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
import '../../../widgets/not_found_widget.dart';
import '../../../widgets/on_screen_loader.dart';
import '../controller/invite_controller.dart';

class RedeoTabPage extends StatefulWidget {
  const RedeoTabPage({Key? key}) : super(key: key);

  @override
  State<RedeoTabPage> createState() => _RedeoTabPageState();
}

class _RedeoTabPageState extends State<RedeoTabPage> {
  InviteController inviteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => inviteController.redeoListLoading.value
          ? OnScreenLoader()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${inviteController.tempRedeoList.value.length} Redeo Contact',
                        style: w900_15(),
                      ),
                      GestureDetector(
                        onTap: () {
                          inviteController.tempRedeoList.forEach((element) {
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
                SearchWidget(hint: 'Search Redeo Contact', onChange: inviteController.executeRedeoSearch),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                    child: Obx(
                  () => inviteController.tempRedeoList.value.isEmpty
                      ? Center(
                        child: SingleChildScrollView(
                          child: NotFoundWidget(
                              title: 'No Redeo contacts found',
                            ),
                        ),
                      )
                      : ListView.builder(
                          itemCount: inviteController.tempRedeoList.value.length,
                          itemBuilder: (context, index) {
                            return RedeoTile(
                              model: inviteController.tempRedeoList.value[index],
                              onTap: () {
                                inviteController
                                        .tempRedeoList.value[index].selected =
                                    !inviteController
                                        .tempRedeoList.value[index].selected;
                                inviteController.refreshCount();
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

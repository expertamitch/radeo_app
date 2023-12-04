import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/contact_tile.dart';

import '../../../../../assets/images.dart';
import '../../../../../styling/app_colors.dart';
import '../../../../../styling/font_style_globle.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../../widgets/not_found_widget.dart';
import '../../../../../widgets/on_screen_loader.dart';
import '../../../../invite/controller/invite_controller.dart';

class InviteContactTabPage extends StatefulWidget {
  const InviteContactTabPage({Key? key}) : super(key: key);

  @override
  State<InviteContactTabPage> createState() => _InviteContactTabPageState();
}

class _InviteContactTabPageState extends State<InviteContactTabPage> {
  InviteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
        child: controller.contactListLoading.value
            ? OnScreenLoader()
            : Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.tempContactsList.length} Contacts',
                    style: w900_15(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SearchWidget(
                hint: 'Search Contact...',
                onChange: controller.executeContactSearch),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: controller.tempContactsList.isEmpty
                  ? SingleChildScrollView(
                child: NotFoundWidget(
                  title: 'No contacts found',
                ),
              )
                  : ListView.builder(
                  itemCount: controller.tempContactsList.length,
                  itemBuilder: (context, index) {
                    return ContactTile(
                      model: controller.tempContactsList[index],
                      onTap: () {
                        for (int i = 0;
                        i <
                            controller
                                .tempContactsList.length;
                        i++) {
                          if (i != index)
                            controller.tempContactsList[i]
                                .selected = false;
                        }
                        controller.tempContactsList[index]
                            .selected =
                        !controller
                            .tempContactsList[index].selected;

                        controller.tempRedeoList
                            .forEach((element) {
                          element.selected = false;
                        });

                        setState(() {});
                      },
                    );
                  }),
            )
          ],
        )));
  }
}

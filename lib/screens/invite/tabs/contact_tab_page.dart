import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/contact_tile.dart';

import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/image_view.dart';
import '../../../widgets/not_found_widget.dart';
import '../../../widgets/on_screen_loader.dart';
import '../controller/invite_controller.dart';

class ContactTabPage extends StatefulWidget {
  const ContactTabPage({Key? key}) : super(key: key);

  @override
  State<ContactTabPage> createState() => _ContactTabPageState();
}

class _ContactTabPageState extends State<ContactTabPage> {
  InviteController inviteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => inviteController.contactListLoading.value
            ? OnScreenLoader()
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${inviteController.tempContactsList.value.length} Contacts',
                          style: w900_15(),
                        ),
                        GestureDetector(
                          onTap: () {
                            inviteController.tempContactsList.forEach((element) {
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
                  SearchWidget(hint: 'Search Contact...', onChange: inviteController.executeContactSearch),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Obx(() => inviteController.tempContactsList.value.isEmpty
                        ? Center(
                          child: SingleChildScrollView(
                            child: NotFoundWidget(
                                title: 'No contacts found',
                              ),
                          ),
                        )
                        : ListView.builder(
                            itemCount: inviteController.tempContactsList.value.length,
                            itemBuilder: (context, index) {
                              return ContactTile(
                                model: inviteController.tempContactsList.value[index],
                                onTap: () {
                                  inviteController
                                          .tempContactsList.value[index].selected =
                                      !inviteController
                                          .tempContactsList.value[index].selected;
                                  inviteController.refreshCount();
                                  setState(() {});
                                },
                              );
                            })),
                  )
                ],
              )));
  }
}

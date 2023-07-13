import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                          '${inviteController.contacts.value.length} Contacts',
                          style: w900_15(),
                        ),
                        GestureDetector(
                          onTap: () {
                            inviteController.contacts.forEach((element) {
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
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.symmetric(horizontal: 18),
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
                              hintText: 'Search Contact...',
                              hintStyle: w300_12(
                                color: AppColors.dark2GreyColor,
                              ),
                              isDense: true),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Obx(() => inviteController.contacts.value.isEmpty
                        ? NotFoundWidget(
                            title: 'No contacts found',
                          )
                        : ListView.builder(
                            itemCount: inviteController.contacts.value.length,
                            itemBuilder: (context, index) {
                              return ContactTile(
                                model: inviteController.contacts.value[index],
                                onTap: () {
                                  inviteController
                                          .contacts.value[index].selected =
                                      !inviteController
                                          .contacts.value[index].selected;
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/tiles/contact_tile.dart';

import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/not_found_widget.dart';
import '../../../../widgets/on_screen_loader.dart';
import '../../controller/contacts_controller.dart';

class AssignContactTabPage extends StatefulWidget {
  const AssignContactTabPage({Key? key}) : super(key: key);

  @override
  State<AssignContactTabPage> createState() => _AssignContactTabPageState();
}

class _AssignContactTabPageState extends State<AssignContactTabPage> {
  ContactsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => controller.contactListLoading.value
            ? OnScreenLoader()
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${controller.contacts.value.length} Contacts',
                          style: w900_15(),
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
                    child: Obx(() => controller.contacts.value.isEmpty
                        ? NotFoundWidget(
                            title: 'No contacts found',
                          )
                        : ListView.builder(
                            itemCount: controller.contacts.value.length,
                            itemBuilder: (context, index) {
                              return ContactTile(
                                model: controller.contacts.value[index],
                                onTap: () {
                                  for (int i = 0;
                                      i < controller.contacts.value.length;
                                      i++) {
                                    if (i != index)
                                      controller.contacts.value[i].selected =
                                          false;
                                  }
                                  controller.contacts.value[index].selected =
                                      !controller
                                          .contacts.value[index].selected;

                                  controller.redeoList.value.forEach((element) {
                                    element.selected = false;
                                  });

                                  setState(() {});
                                },
                              );
                            })),
                  )
                ],
              )));
  }
}

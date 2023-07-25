import 'dart:io';

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/screens/create_message/text_message/show_text_message_sheet.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../../assets/images.dart';
import '../../../models/custom_message_model.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../utils/common_dialogs.dart';

class SelectTextMessagePage extends StatefulWidget {
  const SelectTextMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectTextMessagePage> createState() => _SelectTextMessagePageState();
}

class _SelectTextMessagePageState extends State<SelectTextMessagePage> {
  TextEditingController searchController = TextEditingController();
  MessageController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGreyColor,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: SafeArea(
                child: Container(
              decoration: const BoxDecoration(
                color: AppColors.darkGreyColor,
              ),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  searchIconColor: AppColors.purpleColor,
                  backIconColor: Colors.black,
                  centerTitle: 'Select or Create New',
                  textStyle: w600_14(),
                  centerTitleStyle: w900_16(),
                  backIcon:
                      Platform.isAndroid ? Icons.arrow_back_outlined : null,
                  onChanged: (text) {
                    setState(() {});
                  },
                  searchTextEditingController: searchController,
                  horizontalPadding: 5),
            ))),
        body: Container(
          color: Colors.white,
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.enterTextMessageScreen)?.then((value) {
                  if (value != null && value is int) {
                    Get.back(result: value);
                  }
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(
                          path: Images.textFileIcon,
                          height: 14,
                          color: AppColors.purpleColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Create Message',
                          style: w600_14(
                            color: AppColors.purpleColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      color: AppColors.borderGreyColor,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                    itemCount: controller.textMessageList.value.length,
                    itemBuilder: (context, index) {
                      return textListTile(
                          controller.textMessageList.value[index]);
                    })))
          ]),
        ));
  }

  textListTile(
    CustomMessage message,
  ) {
    return GestureDetector(
      onTap: () {
        Get.back(result: message.id!);
      },
      child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.textFileIcon,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        message.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: w300_13(),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  showTextMessageBottomSheet(message.content!);

                },
                child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye,
                        size: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showConfirmationDialog(
                      context, "Do you want to delete this text?",
                      yesCallback: () async {
                    Get.back();
                    controller.deleteTextMessage(message.id!);
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(
                        path: Images.deleteIcon,
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          )),
    );
  }
}

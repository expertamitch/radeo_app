import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/read_unread_list_model.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/read_unread/read_unread_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class ReadUnreadScreen extends StatefulWidget {
  @override
  _ReadUnreadScreenState createState() => _ReadUnreadScreenState();
}

class _ReadUnreadScreenState extends State<ReadUnreadScreen> {
  ReadUnreadController controller = Get.find();

  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    controller.getMesageList();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          if (controller.readUnreadMessageModel?.info?.nextPageUrl != null) {
            isLoading = !isLoading;
            controller.getPaginatedMessageList().then((value) => null);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Read Unread',
        ),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(() => controller.messageListLoading.value
                ? OnScreenLoader()
                : controller.messagesList.value.isEmpty
                    ? NotFoundWidget(
                        title: 'No messages found',
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) =>
                            Divider(color: AppColors.greyColor),
                        itemCount: controller.messagesList.value.length,
                        itemBuilder: (context, index) {
                          return getItem(controller.messagesList.value[index]);
                        })),
          ),
        ]));
  }

  Widget getItem(ReadUnreadMessageModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.readDetailScreen, arguments: model);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              path: Images.icLocation,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.location ?? '',
                    style: w600_13(color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      DateFormat('dd MMM yyyy, HH:mm a')
                          .format(model.updatedAt!),
                      style: w300_11(
                        color: Color(0XFF8E8E8E),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12,
                ),
                ImageView(
                  path: model.isRead == 1
                      ? Images.icReadCheck
                      : Images.icUnreadCheck,
                  width: 26,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  model.isRead == 1 ? 'Read' : 'Unread',
                  style: w300_11(
                      color: model.isRead == 1
                          ? Color(0XFF74167B)
                          : Color(0XFF8E8E8E)),
                ),
                Text(model.messageContent??'', style: w300_12(color: Colors.black),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

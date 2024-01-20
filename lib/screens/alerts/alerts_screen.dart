import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/notification_list_model.dart';
import 'package:redeo/screens/alerts/alerts_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../styling/app_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class AlertsScreen extends StatefulWidget {
  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  AlertsController controller = Get.find();

  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    controller.getNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          if (controller.notificationListModel?.info?.nextPageUrl != null) {
            isLoading = !isLoading;
            controller.getPaginatedNotificationsList().then((value) => null);
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
          title: 'Notifications',
        ),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(() => controller.notificationsListLoading.value
                ? OnScreenLoader()
                : controller.notificationsList.value.isEmpty
                    ? NotFoundWidget(
                        title: 'No notifications found',
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) => Divider(color: AppColors.greyColor),
                        itemCount: controller.notificationsList.value.length,
                        itemBuilder: (context, index) {
                          return getItem(
                              controller.notificationsList.value[index]);
                        })),
          ),
        ]));
  }

  Widget getItem(NotificationData model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.body??'',
            style: w300_14(color: Colors.black),
          ),
          SizedBox(height: 10,),

          Text(timeago.format(model.updatedAt!),style: w300_11(color: Color(0XFF8E8E8E)),)
        ],
      ),
    );
  }
}

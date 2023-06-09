import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/message_controller.dart';

class HomePageController extends GetxController {
  MessageController messageController = Get.isRegistered<MessageController>()
      ? Get.find<MessageController>()
      : Get.put(MessageController(), permanent: true);

  late GlobalKey<ScaffoldState> drawerKey;

  RxBool timerStarted = false.obs;

  List<String> menuItems = [
    'Field Log',
    'NOEs',
    'Message',
    'Chat',
    'Returns',
    'Groups',
    'Events',
    'DNCs',
    'Territory',
    'Reports',
  ];

  RxInt currentSelectedIndex = 0.obs;

  openDrawer() {
    drawerKey.currentState!.openDrawer();
  }

  closeDrawer() {
    // drawerKey.currentState!.closeDrawer();
    Navigator.pop(drawerKey.currentContext!);
  }
}

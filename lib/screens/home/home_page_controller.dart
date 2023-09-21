import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/models/message_only_model.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/widgets/loader.dart';

import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';
import '../notice_of_event/notice_of_event_controller.dart';

class HomePageController extends GetxController {
  MessageController messageController = Get.isRegistered<MessageController>()
      ? Get.find<MessageController>()
      : Get.put(MessageController(), permanent: true);

  NoticeOfEventController noeContoller = Get.isRegistered<NoticeOfEventController>()
      ? Get.find<NoticeOfEventController>()
      : Get.put(NoticeOfEventController(), permanent: true);


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


  Future<MessageOnlyModel?> sendQR(String id) async {
    try {
      showLoader();
      var result = await BackendRepo().sendQr(id);
      showSuccessSnackBar(result.message!);
      hideLoader();

    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return null;
    }
  }

}

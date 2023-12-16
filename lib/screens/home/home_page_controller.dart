import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/message_only_model.dart';
import 'package:redeo/screens/chat/chat_controller.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/widgets/loader.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../models/timer_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';
import '../notice_of_event/notice_of_event_controller.dart';

class HomePageController extends GetxController {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  int seconds = 0;
  RxString showTime = "00:00:00".obs;


  MessageController messageController = Get.isRegistered<MessageController>()
      ? Get.find<MessageController>()
      : Get.put(MessageController(), permanent: true);

  ChatController chatController = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController(), permanent: true);

  NoticeOfEventController noeContoller =
  Get.isRegistered<NoticeOfEventController>()
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
    'Add Contact',
  ];

  RxInt currentSelectedIndex = 0.obs;

  @override
  void onInit() {
    getTimer();

    stopWatchTimer.secondTime.listen((value) {
      seconds = value;
      showTime.value = format(Duration(seconds: seconds));
      print('secondTime $value');
    });

    super.onInit();
  }

  format(Duration d) =>
      d
          .toString()
          .split('.')
          .first
          .padLeft(8, "0");

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

  Future<TimerModel?> getTimer() async {
    try {
      var result = await BackendRepo().getTimer();

      setTime(result,fromGetTime: true);
    } on InternetException {
      return null;
    } catch (e) {
      showErrorSnackBar(e.toString());

      return null;
    }
  }


  sendTimer() async {
    try {
      DateFormat dateOnlyFormat = DateFormat('yyyy-MM-dd');
      DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      Map<String, dynamic> map = {};
      map['status'] = timerStarted.value ? 'started' : 'stopped';
      map['time'] = showTime.value;
      map['date'] = dateOnlyFormat.format(DateTime.now());
      map['last_updated_time'] = dateTimeFormat.format(DateTime.now());

      showLoader();
      var result = await BackendRepo().postTimer(map: map);
      // setTime(result, fromGetTime: false);
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


  setTime(TimerModel? result,{required bool fromGetTime}) {

    if (result?.info != null) {
      // check if it is next day
      DateFormat dateOnlyFormat = DateFormat('yyyy-MM-dd');
      DateTime serverDate = dateOnlyFormat.parse(result!.info!.date!);
      DateTime currentDate = dateOnlyFormat.parse(
          dateOnlyFormat.format(DateTime.now()));

      if (!serverDate.isAtSameMomentAs(currentDate) ) {
        showTime.value = '00:00:00';
        timerStarted.value = false;
        sendTimer();
      }
       else if (result.info!.status!.toLowerCase() == 'stopped') {
        //   timer is stopped, get duration and add to stopwatch
        Duration duration = parseDuration(result.info!.time!);
        stopWatchTimer.setPresetTime(mSec: duration.inMilliseconds);
        showTime.value = format(duration);
        timerStarted.value = false;
      } else if (result.info!.status!.toLowerCase() == 'started') {
        Duration duration = parseDuration(result.info!.time!);
        DateTime startTime =
        DateTime.parse(result.info!.lastUpdatedTime!);

        // duration from last update time(when started) and current time, we will have total duration of timer from that time
        Duration diffDuration = DateTime.now().difference(startTime);

        stopWatchTimer.setPresetTime(
            mSec: duration.inMilliseconds + (fromGetTime?diffDuration.inMilliseconds:0));

        stopWatchTimer.onStartTimer();
        timerStarted.value = true;
      }





    }
  }


  Duration parseDuration(String durationString) {
    List<String> components = durationString.split(':');

    int hours = int.parse(components[0]);
    int minutes = int.parse(components[1]);
    int seconds = int.parse(components[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }


}

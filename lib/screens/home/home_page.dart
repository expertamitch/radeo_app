import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import 'package:redeo/screens/chat/chat_controller.dart';
import 'package:redeo/screens/chat/chat_page.dart';
import 'package:redeo/screens/create_contact/existing_contacts/existing_contacts_page.dart';
import 'package:redeo/screens/create_message/create_message_page.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/screens/do_not_call/controller/dnc_controller.dart';
import 'package:redeo/screens/event/event_controller.dart';
import 'package:redeo/screens/event/events_page.dart';
import 'package:redeo/screens/field_service/field_log_controller.dart';
import 'package:redeo/screens/field_service/field_service_page.dart';
import 'package:redeo/screens/groups/controller/groups_controller.dart';
import 'package:redeo/screens/groups/groups_page.dart';
import 'package:redeo/screens/home/home_page_controller.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import 'package:redeo/screens/plans/plans_controller.dart';
import 'package:redeo/screens/plans/plans_screen.dart';
import 'package:redeo/screens/read_unread/read_unread_screen.dart';
import 'package:redeo/screens/report/reports_controller.dart';
import 'package:redeo/screens/report/reports_page.dart';
import 'package:redeo/screens/return_visits/return_visits.dart';
import 'package:redeo/screens/territory/controller/territory_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/utils/common_dialogs.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../utils/snackbar_util.dart';
import '../do_not_call/dnc_territory_screen.dart';
import '../notice_of_event/notice_of_event_controller.dart';
import '../territory/territory_list_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomePageController controller = Get.isRegistered<HomePageController>()
      ? Get.find<HomePageController>()
      : Get.put(HomePageController());

  final GroupsController groupsController = Get.isRegistered<GroupsController>()
      ? Get.find<GroupsController>()
      : Get.put(GroupsController());

  final EventController eventController = Get.isRegistered<EventController>()
      ? Get.find<EventController>()
      : Get.put(EventController());

  final PlansController plansController = Get.isRegistered<PlansController>()
      ? Get.find<PlansController>()
      : Get.put(PlansController());

  final FieldLogController fieldLogController =
      Get.isRegistered<FieldLogController>()
          ? Get.find<FieldLogController>()
          : Get.put(FieldLogController());

  final ReportsController reportsController =
      Get.isRegistered<ReportsController>()
          ? Get.find<ReportsController>()
          : Get.put(ReportsController(), permanent: true);

  final DNCController dncController = Get.isRegistered<DNCController>()
      ? Get.find<DNCController>()
      : Get.put(DNCController());

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a k

  @override
  void initState() {
    fieldLogController.getFieldLog(
        date: DateFormat('yyyy/MM/dd').format(fieldLogController.selectedDate));

    controller.drawerKey = _key;

    AuthController authController = Get.find();
    authController.saveFirebaseToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: appDrawer(),
      body: Obx(() => IndexedStack(
            index: controller.currentSelectedIndex.value,
            children: [
              FieldServicePage(),
              CreateNoticeOfEvent(),
              CreateMessagePage(),
              ChatPage(),
              ReturnVisitsPage(),
              GroupsPage(),
              EventPage(),
              DNCTerritoryScreen(),
              TerritoryListScreen(),
              ReportsPage(),
              ExistingContactsPage(),
              ReadUnreadScreen(),
              PlansScreen()
            ],
          )),
    );
  }

  appDrawer() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'REDEO',
                  style: w900_30(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageView(
                    path: Images.closeIcon,
                  ),
                )
              ],
            ),
            SizedBox(
                height: 45.h,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () async {
                      Navigator.pop(context);

                      /* if(Platform.isIOS) {
                        scan();
                        return;
                      }*/
                      var cameraStatus = await Permission.camera.request();
                      if (cameraStatus.isGranted) {
                      } else if (cameraStatus ==
                          PermissionStatus.permanentlyDenied) {
                        showConfirmationDialog(context,
                            "You have denied camera permission. To create new video, you need to allow permission. Press Yes to open settings and allow permission.",
                            yesCallback: () async {
                          Get.back();
                          await openAppSettings();
                        });
                      }

                      var audioStatus = await Permission.microphone.request();
                      if (audioStatus.isGranted) {
                      } else if (audioStatus ==
                          PermissionStatus.permanentlyDenied) {
                        showConfirmationDialog(context,
                            "You have denied microphone permission. To create new video, you need to allow permission. Press Yes to open settings and allow permission.",
                            yesCallback: () async {
                          Get.back();
                          await openAppSettings();
                        });
                      }

                      var camera = await Permission.camera.status;
                      var audio = await Permission.microphone.status;
                      if (camera.isGranted && audio.isGranted) scan();
                      // Get.toNamed(Routes.scanQrScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(
                          path: Images.qrCodeScanIcon,
                          color: Colors.white,
                          height: 23,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Scan QR code',
                          style: w900_14(color: Colors.white),
                        ),
                      ],
                    ))),
          ],
        )),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.menuItems.length,
            itemBuilder: (c, i) {
              return getDrawerMenuItem(
                  title: controller.menuItems[i],
                  onTap: () {
                    controller.closeDrawer();

                    Future.delayed(Duration(milliseconds: 0)).then((value) {
                      controller.currentSelectedIndex.value = i;

                      if (controller.currentSelectedIndex.value == 0) {
                        FieldLogController controller = Get.find();
                        controller.haveMore = false;
                        controller.page = 1;
                        controller.getFieldLog(
                            date: DateFormat('yyyy/MM/dd')
                                .format(fieldLogController.selectedDate));
                      } else if (controller.currentSelectedIndex.value == 3) {
                        //  groups
                        ChatController controller = Get.find();
                        controller.getChatList();
                      } else if (controller.currentSelectedIndex.value == 6) {
                        //  groups
                        EventController controller = Get.find();
                        controller.getEventsList();
                      } else if (controller.currentSelectedIndex.value == 5) {
                        //  groups
                        GroupsController controller = Get.find();
                        controller.getGroupsList();
                      } else if (controller.currentSelectedIndex.value == 7) {
                        DNCController controller = Get.find();
                        controller.getTerritoryList();
                      } else if (controller.currentSelectedIndex.value == 8) {
                        TerritoryController controller = Get.find();
                        controller.getTerritoryList();
                      }
                      else if (controller.currentSelectedIndex.value == 9) {
                        ReportsController controller = Get.find();
                        controller.getReports(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                      }
                      else if (controller.currentSelectedIndex.value == 2) {
                        MessageController msgController = Get.find();
                        msgController.reset();
                      } else if (controller.currentSelectedIndex == 1) {
                        NoticeOfEventController controller = Get.find();
                        controller.reset();
                      } else if (controller.currentSelectedIndex == 4) {
                        NoticeOfEventController controller = Get.find();
                        controller.getNOEList();
                      }
                      else if (controller.currentSelectedIndex.value == 12) {
                        PlansController controller = Get.find();
                        controller.getUserPlan();
                        controller.getPlans();
                      }


                    });
                  });
            }),
        SizedBox(height: (MediaQuery.of(context).size.height * 0.02).h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  showLogoutConfirmation(
                    context,
                  );
                },
                child: Container(
                  height: 45.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    'Logout',
                    style: w600_14(color: Colors.red),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: SizedBox(
                    height: 45.h,
                    child: Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: controller.timerStarted.value
                                ? AppColors.purpleColor
                                : Colors.orangeAccent),
                        onPressed: () {
                          controller.timerStarted.value =
                              !controller.timerStarted.value;

                          if (controller.timerStarted.value)
                            controller.stopWatchTimer.onStartTimer();
                          else
                            controller.stopWatchTimer.onStopTimer();

                          controller.sendTimer();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.timerStarted.value
                                  ? controller.showTime.value
                                  : 'Start Timer',
                              style: w900_14(color: Colors.white),
                            ),
                            Spacer(),
                            Icon(controller.timerStarted.value
                                ? Icons.pause
                                : Icons.play_arrow),
                          ],
                        ))))),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        SizedBox(height: (MediaQuery.of(context).size.height * 0.02).h),
      ],
    ));
  }

  scan() {
    Get.toNamed(Routes.qrScanner)?.then((value) {
      if (value != null) {
        setState(() async {
          if (value.toString().split('/').last.indexOf('-') > 0) {
            String result = value.toString().split('/').last;

            await controller.sendQR(result);
            Get.back();
          } else {
            showErrorSnackBar('Invalid Redeo QR');
          }
        });
      }
    });
  }

  Widget getDrawerMenuItem(
      {VoidCallback? onTap, required String title, String? route}) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(context);
            Get.toNamed(route!);
          },
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
            // color: Colors.red,
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        width: double.maxFinite,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 18),
        child: Text(
          title,
          style: w600_14(),
        ),
      ),
    );
  }
}

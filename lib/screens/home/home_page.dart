import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/chat/chat_page.dart';
import 'package:redeo/screens/create_message/create_message_page.dart';
import 'package:redeo/screens/do_not_call/do_not_call_page.dart';
import 'package:redeo/screens/event/events_page.dart';
import 'package:redeo/screens/field_service/field_service_page.dart';
import 'package:redeo/screens/groups/groups_page.dart';
import 'package:redeo/screens/home/home_page_controller.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import 'package:redeo/screens/report/reports_page.dart';
import 'package:redeo/screens/return_visits/return_visits.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/image_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomePageController controller = Get.isRegistered<HomePageController>()
      ? Get.find<HomePageController>()
      : Get.put(HomePageController());

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a k

  @override
  void initState() {
    controller.drawerKey = _key;
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
              ReturnVisitsPage(),
              CreateNoticeOfEvent(),
              CreateMessagePage(),
              ChatPage(),
              EventPage(),
              EventPage(),
              GroupsPage(),
              ReportsPage(),
              DoNotCallPage()
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
                    onPressed: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.scanQrScreen);
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

                    Future.delayed(Duration(milliseconds: 0)).then(
                        (value) => controller.currentSelectedIndex.value = i);
                  });
            }),
        SizedBox(height: (MediaQuery.of(context).size.height * 0.02).h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
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
          ],
        ),
      ],
    ));
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
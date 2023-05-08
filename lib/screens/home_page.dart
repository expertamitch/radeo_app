import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/image_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ElevatedButton(onPressed: () {}, child: Text('Reports Page')),
            // ElevatedButton(onPressed: () {}, child: Text('Notice of Event')),
            // ElevatedButton(onPressed: () {}, child: Text('Return Visits Page')),
            // ElevatedButton(onPressed: () {}, child: Text('Event Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.createMessageScreen);
                },
                child: Text('Create Messages')),
            // ElevatedButton(onPressed: () {}, child: Text('Field Service Page')),
            // ElevatedButton(onPressed: () {}, child: Text('Message Page')),
            // ElevatedButton(onPressed: () {}, child: Text('Do Not Call Page')),
            // ElevatedButton(onPressed: () {}, child: Text('Groups')),
          ],
        ),
      ),
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
                height: 50,
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
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Scan QR code',
                          style: w600_14(color: Colors.white),
                        ),
                      ],
                    ))),
          ],
        )),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.createNoticeOfEventScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'NOE',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.returnVisitsScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Return',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.fieldServiceScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Filed Service',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.messagePageScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Message',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.eventScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Event',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.groupsPageScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Group',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.reportsScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Report',
              style: w600_14(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.doNotCallScreen);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(color: AppColors.borderGreyColor))),
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'DNC',
              style: w600_14(),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Logout',
              style: w600_14(color: Colors.red),
            ),
          ),
        ),
      ],
    ));
  }
}

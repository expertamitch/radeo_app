import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/route/routes.dart';

class DummyHomepage extends StatefulWidget {
  const DummyHomepage({Key? key}) : super(key: key);

  @override
  State<DummyHomepage> createState() => _DummyHomepageState();
}

class _DummyHomepageState extends State<DummyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.createNoticeOfEventScreen);
                },
                child: Text('Notice of Event')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.eventScreen);
                },
                child: Text('Event Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.scanQrScreen);
                },
                child: Text('Scan Qr Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.createMessageScreen);
                },
                child: Text('Create Messages')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.fieldServiceScreen);
                },
                child: Text('Field Service Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.messagePageScreen);
                },
                child: Text('Message Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.doNotCallScreen);
                },
                child: Text('Do Not Call Page')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.groupsPageScreen);
                },
                child: Text('Groups')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/create_message_page.dart';
import 'package:redeo/screens/do_not_call/do_not_call_page.dart';
import 'package:redeo/screens/event/events_page.dart';
import 'package:redeo/screens/groups/groups_page.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import 'package:redeo/screens/field_service/field_service_page.dart';
import 'package:redeo/screens/message/message_page.dart';
import 'package:redeo/screens/scan_qr_page.dart';

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
                  Get.to(CreateNoticeOfEvent());
                },
                child: Text('Notice of Event')),
            ElevatedButton(
                onPressed: () {
                  Get.to(EventPage());
                },
                child: Text('Event Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(ScanQrPage());
                },
                child: Text('Scan Qr Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(CreateMessagePage());
                },
                child: Text('Create Messages')),
            ElevatedButton(
                onPressed: () {
                  Get.to(FieldServicePage());
                },
                child: Text('Field Service Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(MessagePage());
                },
                child: Text('Message Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(DoNotCallPage());
                },
                child: Text('Do Not Call Page')),
            ElevatedButton(
                onPressed: () {
                  Get.to(GroupsPage());
                },
                child: Text('Groups')),
          ],
        ),
      ),
    );
  }
}

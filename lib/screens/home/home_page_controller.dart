import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {

  late GlobalKey<ScaffoldState> drawerKey;


  List<String> menuItems = [
    'Field Service',
    'Return',
    'NOE',
    'Message',
    'Chat',
    'Notification',
    'Event',
    'Group',
    'Report',
    'DNC'
  ];

  RxInt currentSelectedIndex = 0.obs;


  openDrawer(){
    drawerKey.currentState!.openDrawer();
  }

  closeDrawer(){
    // drawerKey.currentState!.closeDrawer();
    Navigator.pop(drawerKey.currentContext!);

  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {

  late GlobalKey<ScaffoldState> drawerKey;

  RxBool timerStarted=false.obs;


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


  openDrawer(){
    drawerKey.currentState!.openDrawer();
  }

  closeDrawer(){
    // drawerKey.currentState!.closeDrawer();
    Navigator.pop(drawerKey.currentContext!);

  }
}

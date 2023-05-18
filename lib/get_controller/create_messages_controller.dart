import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateMessagesController extends GetxController {
  String? selectedMessageType; //Text, Audio, Video

  String selectedResponseType = 'Custom'; //Open, Custom
  List<Map<String, dynamic>> selectedResponseList = [
    {'title': 'The info was helpful, Thanks', 'isSelected': false},
    {'title': 'The info was helpful, Send more', 'isSelected': false},
    {'title': 'Interested in free home bible study', 'isSelected': false},
    {'title': 'Not Interested in this info', 'isSelected': false},
    {'title': 'Please do not contact any more', 'isSelected': false},
  ];
}

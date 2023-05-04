import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoticeOfEventController extends GetxController {
  // ForgotPasswordModel? model;
  // Rx<PasswordResetModel>? model;
  File? uploadImg;
  File? attachment;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController territoryController = TextEditingController();
  TextEditingController boysController = TextEditingController(text: '00');
  TextEditingController girlsController = TextEditingController(text: '00');
  TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  DateTime? setReturnVisitDate;

  String noticeTypes = ''; //Scripture, Magazine, Video, Other

  int? attributesStatus; //Single, Married, Divorced

  int? indicatorStatus; //openForEncouragment, Don not contract
  int? level;
}

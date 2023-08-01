import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/territory_list_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';
import '../../widgets/loader.dart';

class NoticeOfEventController extends GetxController {

  List<String> indicatorsList=['Open for Encouragement', 'Do Not Contact'];




  bool showDateTimeError = false;
  bool showSetReturnVisitDateTimeError = false;
  bool noticeTypesError = false;
  bool showAttributesStatusError = false;
  bool showIndicatorStatusError = false;
  bool showAttachmentError = false;
  bool showTerritoryError = false;
  bool showLevelError = false;
  bool notifySelf = false;
  bool showTimePeroidDDError= false;
  bool showNotifyMeDDError = false;
  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;

  File? uploadImg;
  String? attachmentFile;
  TerritoryInfo? territoryInfo;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
   TextEditingController boysController = TextEditingController(text: '00');
  TextEditingController girlsController = TextEditingController(text: '00');
  TextEditingController noteController = TextEditingController();
  TextEditingController contentNameController = TextEditingController();
  DateTime? selectedDate;
  DateTime? setReturnVisitDate;

  String contentTypes = ''; //Scripture, Magazine, Video, Other

  int? attributesStatus; //Single, Married, Divorced
  String? selectedTimePeroidDD; // 'Everyday','Weekly','Monthly','Yearly'
  String? selectedNotifyMeDD; // 'Everyday','Weekly','Monthly','Yearly'
  int? indicatorStatus; //openForEncouragment, Don not contract
  int? level;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  reset() {
    formKey.currentState?.reset();
    autovalidateMode=AutovalidateMode.disabled;
    showDateTimeError = false;
    showSetReturnVisitDateTimeError = false;
    noticeTypesError = false;
    showAttributesStatusError = false;
    showIndicatorStatusError = false;
    showAttachmentError = false;
    showLevelError = false;
    showNotifyMeDDError = false;
    showTimePeroidDDError = false;
    showTerritoryError = false;
    notifySelf = false;

    uploadImg = null;
    attachmentFile = null;
    territoryInfo = null;
    nameController.text = '';
    locationController.text = '';
    emailController.text = '';
    contentNameController.text = '';
    telephoneController.text = '';
     boysController.text = '';
    girlsController.text = '';
    noteController.text = '';
    selectedDate = null;
    setReturnVisitDate = null;

    contentTypes = ''; //Scripture, Magazine, Video, Other

    selectedTimePeroidDD = null;
    selectedNotifyMeDD = null;
    attributesStatus = null;

    indicatorStatus = null;
    level = null;
  }


  Future<bool> createNOE() async {
    try {



      Map<String, dynamic> map = {};

      map = {
        'name': nameController.text,
        'location': locationController.text,
        'email': emailController.text,
        'telephone': telephoneController.text,
        'marital_status': attributesStatus==1?'single':attributesStatus==2?'married':'divorced',
        'territory_id': territoryInfo!.id!.toString(),
        'girls': girlsController.text,
        'boys': boysController.text,
        'return_visit_type': selectedTimePeroidDD!.toLowerCase(),
        'notification_self': selectedNotifyMeDD!.toLowerCase(),
        'notification_other': notifySelf,
        'given_content_type': contentTypes.toLowerCase(),
        'given_content_name': contentNameController.text,
        'level': level==1?'cloud':level==2?'rain':'tree',
        'indicators': indicatorStatus==1?'open-for-encourgament':'do-not-call',
        'notes': noteController.text,
        'date_time': DateFormat('YYYY-MM-dd HH:mm:ss').format(selectedDate!),
      };

      var bytes = await uploadImg!.readAsBytes();
        map['name_image'] = MultipartFile(
          bytes,
          filename:
          '${DateTime.now().microsecondsSinceEpoch}.${uploadImg!.path.split('/').last}',
        );



      var bytes1 = await File(attachmentFile!).readAsBytes();
      map['attachments[]'] = MultipartFile(
        bytes1,
        filename:
        '${DateTime.now().microsecondsSinceEpoch}.${attachmentFile!.split('/').last}',
      );

      showLoader();

      var data = await BackendRepo().createNOE(map: map);
      if (data.message != null) {
        showSuccessSnackBar(data.message!);
      }
      hideLoader();
      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return false;
    }
  }

}

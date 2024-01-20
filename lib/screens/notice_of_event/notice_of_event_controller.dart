import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/return_visit_list_model.dart';

import '../../models/territory_list_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';
import '../../widgets/loader.dart';

class NoticeOfEventController extends GetxController {
  List<String> indicatorsList = ['Open for Encouragement', 'Do Not Contact'];

  bool showDateTimeError = false;
  bool showSetReturnVisitDateTimeError = false;
  bool noticeTypesError = false;
  bool showAttributesStatusError = false;
  bool showIndicatorStatusError = false;
  bool showAttachmentError = false;
  bool showTerritoryError = false;
  bool showLevelError = false;
  bool notifySelf = false;
  bool showTimePeroidDDError = false;
  bool showNotifyMeDDError = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
    autovalidateMode = AutovalidateMode.disabled;
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
        'marital_status': attributesStatus == 1
            ? 'single'
            : attributesStatus == 2
                ? 'married'
                : 'divorced',
        'territory_id': territoryInfo!.id!.toString(),
        'territory_name': territoryInfo!.name!.toString(),
        'girls': girlsController.text.isEmpty ? 0 : girlsController.text,
        'boys': boysController.text.isEmpty ? 0 : boysController.text,
        'return_visit_type': selectedTimePeroidDD!.contains('ly')
            ? selectedTimePeroidDD!.replaceAll('ly', '').toLowerCase()
            : selectedTimePeroidDD!.toLowerCase(), //
        'notification_self': selectedNotifyMeDD!.contains('ly')
            ? selectedNotifyMeDD!.replaceAll('ly', '').toLowerCase()
            : selectedNotifyMeDD!.toLowerCase(), //
        'notification_other': !notifySelf ? 0 : 1, //
        'given_content_type': contentTypes.toLowerCase(), //
        'given_content_name': contentNameController.text, //
        'level': level == 1
            ? 'cloud'
            : level == 2
                ? 'rain'
                : 'tree',
        'indicators':
            indicatorStatus == 1 ? 'open-for-encourgament' : 'do-not-call',
        'notes': noteController.text,
        'date_time': DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate!),
        'return_date':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(setReturnVisitDate!),
      };

      showLoader();

      var data = await BackendRepo().createNOE(
          map: map,
          nameImagePath: uploadImg!.path,
          attachmentPath: attachmentFile!);
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

  Future<bool> createReturn(Map<String, dynamic> map) async {
    try {
      showLoader();

      var data = await BackendRepo().createReturn(
        data: map,
      );
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



  RxBool returnListLoading = false.obs;
  RxList<NOEModel> noeList = RxList();
  RxBool noeListLoading = false.obs;
  ReturnVisitListModel? returnVisitListModel = null;

  Future<bool> getNOEList() async {
    try {
      noeList.clear();
      noeListLoading.value = true;
      returnVisitListModel = await BackendRepo().getNOEList();
      noeList.value = returnVisitListModel!.info?.data ?? [];
      noeListLoading.value = false;
      return true;
    } on InternetException {
      noeListLoading.value = false;
      return false;
    } catch (e) {
      noeListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> getPaginatedNOEList() async {
    try {
      returnVisitListModel = await BackendRepo()
          .getNOEList(path: returnVisitListModel!.info!.nextPageUrl!);
      noeList.value.addAll(returnVisitListModel!.info?.data ?? []);
      noeListLoading.value = false;
      noeList.refresh();
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<NOEModel?> getReturnHistory(String id) async {
    try {
      returnListLoading.value = true;
      var result = await BackendRepo().getReturnHistory(id);

      returnListLoading.value = false;
      return result.info!;
    } on InternetException {
      returnListLoading.value = false;
      return null;
    } catch (e) {
      returnListLoading.value = false;
      showErrorSnackBar(e.toString());

      return null;
    }
  }

  RxList<NOEModel> incompleteNoeList = RxList();
  RxBool incompleteNoeListLoading = false.obs;
  ReturnVisitListModel? incompleteReturnVisitListModel = null;

  Future<bool> getIncompleteNOEList() async {
    try {
      incompleteNoeList.clear();
      incompleteNoeListLoading.value = true;
      incompleteReturnVisitListModel = await BackendRepo().getIncompleteNOEList();
      incompleteNoeList.value = incompleteReturnVisitListModel!.info?.data ?? [];
      incompleteNoeListLoading.value = false;
      return true;
    } on InternetException {
      incompleteNoeListLoading.value = false;
      return false;
    } catch (e) {
      incompleteNoeListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> getPaginatedIncompleteNOEList() async {
    try {
      incompleteReturnVisitListModel = await BackendRepo()
          .getIncompleteNOEList(path: incompleteReturnVisitListModel!.info!.nextPageUrl!);
      incompleteNoeList.value.addAll(incompleteReturnVisitListModel!.info?.data ?? []);
      incompleteNoeListLoading.value = false;
      incompleteNoeList.refresh();
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      showErrorSnackBar(e.toString());

      return false;
    }
  }


}

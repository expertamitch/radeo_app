import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_redeo_member_list_response_model.dart';

import '../../../models/phone_contact_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class ContactsController extends GetxController {
  RxList<PhoneContactModel> contacts = RxList();

  List<Info> redeoList = [];
  RxList<Info> tempRedeoList = RxList();

  RxBool contactListLoading = false.obs;
  RxBool redeoListLoading = false.obs;

  Future<bool> getAllRedeoMemberList() async {
    try {
      redeoListLoading.value = true;
      redeoList.clear();
      var result = await BackendRepo().getRedeoMemberList();
      redeoListLoading.value = false;

      redeoList = result.info ?? [];
      tempRedeoList.value = redeoList;

      return true;
    } on InternetException {
      redeoListLoading.value = false;
      return false;
    } catch (e) {
      redeoListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  getPhoneContacts() async {
    print('Getting phone contacts');
    contactListLoading.value = true;
    if (await FlutterContacts.requestPermission()) {
      List<Contact> numbers = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      List<PhoneContactModel> lC = [];

      numbers.forEach((element) {
        if (element.phones.length > 0)
          lC.add(PhoneContactModel(selected: false, phoneContact: element));
      });

      contacts.value = lC;
      contactListLoading.value = false;
    } else
      contactListLoading.value = false;
  }

  @override
  void onInit() {
    getPhoneContacts();
    getAllRedeoMemberList();
    super.onInit();
  }

  executeSearch(String searchedText) {
    tempRedeoList.value = redeoList.map((e) => Info.clone(e)).toList();

    tempRedeoList.value.removeWhere((element) =>
        !element.fullName!.toLowerCase().contains(searchedText.toLowerCase()));
    tempRedeoList.refresh();
  }
}

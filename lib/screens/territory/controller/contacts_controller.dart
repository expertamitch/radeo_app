import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_redeo_member_list_response_model.dart';
import 'package:redeo/models/local_attendant_model.dart';

import '../../../models/all_group_list_response_model.dart';
import '../../../models/phone_contact_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class ContactsController extends GetxController {
   RxList<PhoneContactModel> contacts = RxList();

  RxList<Info> redeoList = RxList();
  RxBool contactListLoading = false.obs;
   RxBool redeoListLoading = false.obs;





  Future<bool> getAllRedeoMemberList() async {
    try {
      redeoListLoading.value = true;
      redeoList.clear();
      var result = await BackendRepo().getRedeoMemberList();
      redeoListLoading.value = false;

      redeoList.value = result.info ?? [];

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
}

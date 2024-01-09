import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_redeo_member_list_response_model.dart';
import 'package:redeo/models/local_attendant_model.dart';

import '../../../models/all_group_list_response_model.dart';
import '../../../models/phone_contact_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';
import '../../widgets/loader.dart';

class AddContactController extends GetxController {
  List<PhoneContactModel> contacts = [];
  RxList<PhoneContactModel> tempContactsList = RxList();

  List<ContactInfo> redeoList = [];
  RxList<ContactInfo> tempRedeoList = RxList();

  RxBool contactListLoading = false.obs;
  RxBool groupsListLoading = false.obs;
  RxBool redeoListLoading = false.obs;

  RxInt selectedMembersCount = 0.obs;

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

      contacts = lC;
      tempContactsList.value = contacts;
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

  executeContactSearch(String searchedText) {
    tempContactsList.value =
        contacts.map((e) => PhoneContactModel.clone(e)).toList();

    tempContactsList.value.removeWhere((element) =>
        !(element.phoneContact.name.first +
                " " +
                element.phoneContact.name.last)
            .toLowerCase()
            .contains(searchedText.toLowerCase()));
    tempContactsList.refresh();
  }

  executeRedeoSearch(String searchedText) {
    tempRedeoList.value = redeoList.map((e) => ContactInfo.clone(e)).toList();

    tempRedeoList.value.removeWhere((element) =>
        !element.fullName!.toLowerCase().contains(searchedText.toLowerCase()));
    tempRedeoList.refresh();
  }

  Future<bool> createContact(String fName, String lName, String phone, String code) async {
    try {
      Map<String, dynamic> map = {};

      map['country_code'] = code;
      map['mobile'] = phone;
      map['first_name'] = fName;
      map['last_name'] = lName;

      showLoader();
      var result = await BackendRepo().createContact(data: map);
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

  Future<bool> editContact(
      String fName, String lName, String phone, String id, String code) async {
    try {
      Map<String, dynamic> map = {};

      map['id'] = id;
      map['country_code'] = code;

      map['mobile'] = phone;
      map['first_name'] = fName;
      map['last_name'] = lName;

      showLoader();
      var result = await BackendRepo().editContact(data: map);
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

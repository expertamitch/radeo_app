import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_redeo_member_list_response_model.dart';
import 'package:redeo/models/local_attendant_model.dart';

import '../../../models/all_group_list_response_model.dart';
import '../../../models/phone_contact_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class InviteController extends GetxController {
  RxList<GroupModel> groupsList = RxList();
  RxList<PhoneContactModel> contacts = RxList();
  RxList<LocalAttendantModel> attendants = RxList();
  RxList<Info> redeoList = RxList();
  RxBool contactListLoading = false.obs;
  RxBool groupsListLoading = false.obs;
  RxBool redeoListLoading = false.obs;
  RxInt selectedMembersCount = 0.obs;

  Future<bool> getAllGroupsList() async {
    try {
      groupsListLoading.value = true;
      groupsList.clear();
      var result = await BackendRepo().getGroupList();
      groupsListLoading.value = false;

      groupsList.value = result.info ?? [];

      return true;
    } on InternetException {
      groupsListLoading.value = false;
      return false;
    } catch (e) {
      groupsListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

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

  createAttendantList() {
    List<GroupModel> selectedGroupsList =
        groupsList.where((p0) => p0.selected).toList();
    List<PhoneContactModel> selectedContactsList =
        contacts.where((p0) => p0.selected).toList();
    List<Info> selectedRedeoContactsList =
        redeoList.where((p0) => p0.selected).toList();
    List<LocalAttendantModel> la = [];

    selectedRedeoContactsList.forEach((element) {
      la.add(LocalAttendantModel(
          selected: false,
          phone: element.mobile??'',
          name:
              "${element.firstName} ${element.lastName}"));
    });

    selectedContactsList.forEach((element) {
      la.add(LocalAttendantModel(
          selected: false,
          phone: element.phoneContact.phones[0].number,
          name:
              "${element.phoneContact.name.first} ${element.phoneContact.name.last}"));
    });

    selectedGroupsList.forEach((element) {
      element.users?.forEach((element) {
        la.add(LocalAttendantModel(
            selected: false,
            phone: element.mobile ?? '',
            name: "${element.firstName ?? ''} ${element.lastName ?? ''}"));
      });
    });

    attendants.value = la;
  }

  refreshCount() {
    selectedMembersCount.value = 0;
    groupsList.value.forEach((element) {
      if (element.selected) {
        var c=element.users?.length??0;
        selectedMembersCount.value = selectedMembersCount.value+c;
      }
    });

    contacts.value.forEach((element) {
      if (element.selected) selectedMembersCount.value++;
    });

    redeoList.value.forEach((element) {
      if (element.selected) selectedMembersCount.value++;
    });

  }

  @override
  void onInit() {
    getAllGroupsList();
    getPhoneContacts();
    getAllRedeoMemberList();
    super.onInit();
  }
}

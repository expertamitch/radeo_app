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
  List<GroupModel> groupsList = [];
  RxList<GroupModel> tempGroupsList = RxList();

  List<PhoneContactModel> contacts = [];
  RxList<PhoneContactModel> tempContactsList = RxList();

  List<Info> redeoList = [];
  RxList<Info> tempRedeoList = RxList();

  List<LocalAttendantModel> attendants = [];
  RxList<LocalAttendantModel> tempAttendantsList = RxList();

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

      groupsList = result.info ?? [];
      tempGroupsList.value = groupsList;

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

  createAttendantList(List<Users>? data) {
    if (data != null) {
      List<LocalAttendantModel> la = [];


      data.forEach((element) {
        element.users!.forEach((element1) {
          la.add(LocalAttendantModel(
              selected: false,
              type: element.contactType!,
              from_group_id: element.contactType == 'group'
                  ? element1.from_group_id
                  : null,
              phone: element1.mobile ?? '',
              name: "${element1.firstName ?? ''} ${element1.lastName ?? ''}"));
        });



      });
      attendants = la;
      tempAttendantsList.value = la;





    } else {
      List<GroupModel> selectedGroupsList =
          tempGroupsList.where((p0) => p0.selected).toList();
      List<PhoneContactModel> selectedContactsList =
          tempContactsList.where((p0) => p0.selected).toList();
      List<Info> selectedRedeoContactsList =
          tempRedeoList.where((p0) => p0.selected).toList();

      List<LocalAttendantModel> la = [];

      selectedRedeoContactsList.forEach((element) {
        la.add(LocalAttendantModel(
            selected: false,
            phone: element.mobile ?? '',
            type: 'redeo',
            name: "${element.firstName} ${element.lastName}"));
      });

      selectedContactsList.forEach((element) {
        la.add(LocalAttendantModel(
            selected: false,
            type: 'phone',
            phone: element.phoneContact.phones[0].number,
            name:
                "${element.phoneContact.name.first} ${element.phoneContact.name.last}"));
      });

      selectedGroupsList.forEach((element) {
        element.users?.forEach((element1) {
          if (element1.users!.length > 0) {
            element1.users!.forEach((data) {
              la.add(LocalAttendantModel(
                  selected: false,
                  type: element1.contactType!,
                  from_group_id: element1.contactType == 'group'
                      ? data.from_group_id
                      : null,
                  phone: data.mobile ?? '',
                  name: "${data.firstName ?? ''} ${data.lastName ?? ''}"));
            });
          }
        });
      });

      attendants= la;
      tempAttendantsList.value = la;
    }
  }

  refreshCount() {
    selectedMembersCount.value = 0;
    tempGroupsList.value.forEach((element) {
      if (element.selected) {
        int c=0;
        element.users?.forEach((element1) {
          c=c+element1.users!.length;
        });
        selectedMembersCount.value = selectedMembersCount.value + c;
      }
    });

    tempContactsList.value.forEach((element) {
      if (element.selected) selectedMembersCount.value++;
    });

    tempRedeoList.value.forEach((element) {
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

  executeGroupSearch(String searchedText) {
    tempGroupsList.value = groupsList.map((e) => GroupModel.clone(e)).toList();

    tempGroupsList.value.removeWhere((element) =>
        !element.groupName!.toLowerCase().contains(searchedText.toLowerCase()));
    tempGroupsList.refresh();
  }

  executeContactSearch(String searchedText) {
    tempContactsList.value =
        contacts.map((e) => PhoneContactModel.clone(e)).toList();

    tempContactsList.value.removeWhere((element) => !(element
        .phoneContact.name.first+" "+element
        .phoneContact.name.last )
        .toLowerCase()
        .contains(searchedText.toLowerCase()));
    tempContactsList.refresh();
  }

  executeRedeoSearch(String searchedText) {
    tempRedeoList.value = redeoList.map((e) => Info.clone(e)).toList();

    tempRedeoList.value.removeWhere((element) =>
        !element.fullName!.toLowerCase().contains(searchedText.toLowerCase()));
    tempRedeoList.refresh();
  }

  executeAttendentSearch(String searchedText) {
    tempAttendantsList.value =
        attendants.map((e) => LocalAttendantModel.clone(e)).toList();

    tempAttendantsList.value.removeWhere((element) =>
        !element.name.toLowerCase().contains(searchedText.toLowerCase()));
    tempAttendantsList.refresh();
  }
}

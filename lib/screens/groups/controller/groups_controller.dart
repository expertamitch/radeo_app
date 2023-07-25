import 'package:get/get.dart';

import '../../../models/all_group_list_response_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';
import '../../../widgets/loader.dart';

class GroupsController extends GetxController {
  RxBool groupsListLoading = false.obs;
  List<GroupModel> groupsList = [];
  RxList<GroupModel> tempGroupsList = RxList();

  @override
  void onInit() {
    getGroupsList();
    super.onInit();
  }

  Future<bool> getGroupsList() async {
    try {
      groupsList.clear();
      groupsListLoading.value = true;
      var result = await BackendRepo().getGroupList();
      groupsList = result.info ?? [];
      tempGroupsList.value = groupsList;
      groupsListLoading.value = false;

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

  Future<bool> createGroup(Map<String, dynamic> data) async {
    try {
      showLoader();
      final result = await BackendRepo().createGroup(data: data);
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

  Future<bool> updateGroup(Map<String, dynamic> data, String id) async {
    try {
      showLoader();
      final result = await BackendRepo().editGroup(data: data, id: id);
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

  Future<bool> deleteGroup(Map<String, dynamic> data) async {
    try {
      showLoader();
      final result = await BackendRepo().deleteGroup(data: data);
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

  executeSearch(String searchedText) {
    tempGroupsList.value = groupsList.map((e) => GroupModel.clone(e)).toList();

    tempGroupsList.value.removeWhere((element) =>
        !element.groupName!.toLowerCase().contains(searchedText.toLowerCase()));
    tempGroupsList.refresh();
  }
}

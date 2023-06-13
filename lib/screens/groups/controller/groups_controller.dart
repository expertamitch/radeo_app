import 'package:get/get.dart';

import '../../../models/all_group_list_response_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';
import '../../../widgets/loader.dart';

class GroupsController extends GetxController {
  RxBool groupsListLoading = false.obs;
  RxList<GroupModel> groupsList = RxList();

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
      groupsList.value = result.info ?? [];
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


}

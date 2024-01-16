import 'package:get/get.dart';

import '../../models/plans_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class ReadUnreadController extends GetxController {
  RxList<PlanDetail> messageList = RxList();

RxBool messageLoading = false.obs;

  Future<bool> getMessages() async {
    try {
      messageLoading.value = true;
      messageList.clear();
      var result = await BackendRepo().getReadUnread();
      messageLoading.value = false;
      messageList.value = result?.info ?? [];
      return true;
    } on InternetException {
      messageLoading.value = false;
      return false;
    } catch (e) {
      messageLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }








}

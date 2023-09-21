import 'package:get/get.dart';
import 'package:redeo/models/field_log_model.dart';
import 'package:redeo/models/return_visit_list_model.dart';

import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class FieldLogController extends GetxController {

  DateTime selectedDate = DateTime.now();



  RxList<NOEModel> fieldLogs = RxList();
  bool haveMore = false;
  int page = 1;

  RxList<NOEModel> noeList = RxList();
  RxBool fieldLogLoading = false.obs;

  Future<bool> getFieldLog({required String date}) async {
    try {
      if (page == 1) fieldLogs.clear();

      fieldLogLoading.value = true;
      FieldLogModel model = await BackendRepo().getFieldLog(date);

      haveMore = model.info?.nextPageUrl != null;

      if (haveMore) page++;

      fieldLogs.addAll(model.info?.data ?? []);
      fieldLogs.refresh();

      fieldLogLoading.value = false;
      return true;
    } on InternetException {
      fieldLogLoading.value = false;
      return false;
    } catch (e) {
      fieldLogLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }
}

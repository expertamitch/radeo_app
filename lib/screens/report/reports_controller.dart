import 'package:get/get.dart';
import 'package:redeo/widgets/loader.dart';

import '../../models/reports_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class ReportsController extends GetxController {
  RxList<ReportInfo> reports = RxList();
  RxBool loading = true.obs;

  Future<bool> getReports(String date) async {
    try {
      loading.value=true;
      reports.clear();
      showLoader();
      var reportsModel = await BackendRepo().getReport(date);
      reports.addAll(reportsModel.info ?? []);
      loading.value=false;

      hideLoader();
      return true;
    } on InternetException {
      loading.value=false;

      hideLoader();
      return false;
    } catch (e) {
      loading.value=false;

      hideLoader();
      showErrorSnackBar(e.toString());
      return false;
    }
  }


  Future<bool> updateReports(
      Map<String, dynamic> map ) async {
    try {



      showLoader();
      var result = await BackendRepo().updateReports(data: map);
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

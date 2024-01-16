import 'package:get/get.dart';

import '../../models/plans_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class PlansController extends GetxController {
  RxList<PlanDetail> plansList = RxList();
  RxInt activePlanId = 0.obs;
  RxBool plansLoading = false.obs;

  Future<bool> getUserPlan() async {
    try {
      plansLoading.value = true;
      var result = await BackendRepo().getUserPlan();
      activePlanId.value = result?.info?.id ?? 0;
      plansLoading.value = false;
      return true;
    } on InternetException {
      plansLoading.value = false;
      return false;
    } catch (e) {
      plansLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<bool> getPlans() async {
    try {
      plansLoading.value = true;
      plansList.clear();
      var result = await BackendRepo().getPlans();
      plansLoading.value = false;
      plansList.value = result?.info ?? [];
      return true;
    } on InternetException {
      plansLoading.value = false;
      return false;
    } catch (e) {
      plansLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<bool> buyPlan(String planId) async {
    try {
      plansLoading.value = true;
      Map<String, dynamic> data = {"plan_id": planId};
      var result = await BackendRepo().buyPlan(data: data);
      await getUserPlan();
      plansLoading.value = false;
      return true;
    } on InternetException {
      plansLoading.value = false;
      return false;
    } catch (e) {
      plansLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<bool> getPaymentIntent(String amount) async {
    try {
      plansLoading.value = true;
      Map<String, dynamic> data = {"amount": amount, "currency": 'usd'};
      var result = await BackendRepo().getPaymentIntent(data);
       plansLoading.value = false;
      return true;
    } on InternetException {
      plansLoading.value = false;
      return false;
    } catch (e) {
      plansLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }
}

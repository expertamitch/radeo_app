import 'package:get/get.dart';

import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class PlansController extends GetxController{

RxBool plansLoading=false.obs;
  @override
  void onInit() {
    getPlans();
     super.onInit();
  }


  Future<bool> getPlans() async {
    try {
      plansLoading.value = true;
      // redeoList.clear();
      var result = await BackendRepo().getPlans();
      plansLoading.value = false;
      // redeoList = result.info ?? [];
      // tempRedeoList.value = redeoList;
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
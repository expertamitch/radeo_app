import 'package:get/get.dart';

import '../../../models/territory_detail_model.dart';
import '../../../models/territory_list_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class TerritoryController extends GetxController {
  RxBool territoryListLoading = false.obs;
  RxBool territoryDetailLoading = false.obs;
  RxList<TerritoryInfo> territoryList = RxList();
  RxList<Addresses> addresses=RxList();



  Future<bool> getTerritoryList() async {
    try {
      territoryList.clear();
      territoryListLoading.value = true;
      var result = await BackendRepo().getTerritoryList();
      territoryList.value = result.info ?? [];
      territoryListLoading.value = false;

      return true;
    } on InternetException {
      territoryListLoading.value = false;
      return false;
    } catch (e) {
      territoryListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> getTerritoryDetail(String id) async {
    try {
      addresses.value.clear();
      territoryDetailLoading.value=true;
      var result = await BackendRepo().getTerritoryDetail(id);
      addresses.value=result.info?.addresses??[];
      territoryDetailLoading.value=false;

      return true;
    } on InternetException {
      territoryDetailLoading.value=false;
      return false;
    } catch (e) {
      territoryDetailLoading.value=false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  @override
  void onInit() {
    getTerritoryList();
    super.onInit();
  }
}

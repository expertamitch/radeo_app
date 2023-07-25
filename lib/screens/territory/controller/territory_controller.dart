import 'package:get/get.dart';
import 'package:redeo/widgets/loader.dart';

import '../../../models/territory_detail_model.dart';
import '../../../models/territory_list_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class TerritoryController extends GetxController {
  RxBool territoryListLoading = false.obs;
  RxBool territoryHistoryLoading = false.obs;
  RxBool territoryDetailLoading = false.obs;
  RxList<TerritoryInfo> territoryList = RxList();
  RxList<TerritoryInfo> territoryHistoryList = RxList();
  List<Addresses> addresses = [];
  RxList<Addresses> tempAddresses = RxList();
  TerritoryDetailModel? detailModel;

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
      addresses.clear();
      tempAddresses.value.clear();
      territoryDetailLoading.value = true;
      var result = await BackendRepo().getTerritoryDetail(id);
      detailModel = result;

      addresses= result.info?.addresses ?? [];
      tempAddresses.value=addresses;
      territoryDetailLoading.value = false;

      return true;
    } on InternetException {
      territoryDetailLoading.value = false;
      return false;
    } catch (e) {
      territoryDetailLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> assignTerritory(
      {required String id, required String assigned_to}) async {
    try {
      addresses.clear();
      showLoader();
      var result =
          await BackendRepo().assignTerritory(id: id, assigned_to: assigned_to);

      hideLoader();

      getTerritoryList();
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

  Future<bool> updateTerritory(
      {required String id, required String status}) async {
    try {
      addresses.clear();
      showLoader();
      var result = await BackendRepo().updateTerritory(id: id, status: status);

      hideLoader();

      getTerritoryList();
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

  Future<bool> getTerritoryHistory() async {
    try {
      territoryHistoryList.clear();
      territoryHistoryLoading.value = true;
      var result = await BackendRepo().getTerritoryHistory();
      territoryHistoryList.value = result.info ?? [];
      territoryHistoryLoading.value = false;

      return true;
    } on InternetException {
      territoryHistoryLoading.value = false;
      return false;
    } catch (e) {
      territoryHistoryLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  executeSearch(String searchedText) {
    tempAddresses.value = addresses.map((e) => Addresses.clone(e)).toList();

    tempAddresses.value.removeWhere((element) =>
    !element.fullAddress!.toLowerCase().contains(searchedText.toLowerCase()));
    tempAddresses.refresh();
  }



}

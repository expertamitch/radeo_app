import 'package:fl_geocoder/fl_geocoder.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/loader.dart';

import '../../../models/dnc_list_response_model.dart';
import '../../../models/territory_detail_model.dart';
import '../../../models/territory_list_model.dart';
import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';
import '../../../utils/snackbar_util.dart';

class DNCController extends GetxController {

  RxBool dncListLoading = false.obs;
  RxBool territoryListLoading = false.obs;

  RxList<TerritoryInfo> territoryList = RxList();
  List<DoNotCalls> dncList = [];
  RxList<DoNotCalls> tempDncList = RxList();

  RxBool territoryDetailLoading = false.obs;

  List<Addresses> addresses = [];
  RxList<Addresses> tempAddresses = RxList();

  TerritoryDetailModel? detailModel;

  Future<bool> getTerritoryList() async {
    try {
      territoryList.clear();
      territoryListLoading.value = true;
      var result = await BackendRepo().getAssignedTerritoryList();
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

  Future<bool> getTerritoryDetail(int id) async {
    try {
      addresses.clear();
      tempAddresses.value.clear();
      territoryDetailLoading.value = true;
      var result = await BackendRepo().getTerritoryDetail(id);
      detailModel = result;

      addresses = result.info?.addresses ?? [];
      tempAddresses.value = addresses;
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

  Future<bool> getDNCList(int id) async {
    try {
      dncList.clear();
      tempDncList.clear;
      dncListLoading.value = true;
      var result = await BackendRepo().getDNCList();

      result.info?.forEach((element) {
        if (element.id == id) {
          tempDncList.value = element.doNotCalls ?? [];
          dncList = element.doNotCalls ?? [];
        }
      });
      dncListLoading.value = false;

      return true;
    } on InternetException {
      dncListLoading.value = false;
      return false;
    } catch (e) {
      dncListLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<String?> addDNC(
      {required String territoryId,
      required String address,
      required String reason}) async {
    try {
      showLoader();
      var result = await BackendRepo().addDNC(
        reason: reason,
        territoryId: territoryId,
        address: address,
      );

      hideLoader();
      return result.message!;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return null;
    }
  }

  executeSearch(String searchedText) {
    tempDncList.value = dncList.map((e) => DoNotCalls.clone(e)).toList();

    tempDncList.value.removeWhere((element) =>
        !element.address!.toLowerCase().contains(searchedText.toLowerCase()));
    tempDncList.refresh();
  }


}

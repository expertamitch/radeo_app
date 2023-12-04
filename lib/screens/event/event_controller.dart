import 'package:get/get.dart';

import '../../models/event_detail_model.dart';
import '../../models/events_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';
import '../../widgets/loader.dart';

class EventController extends GetxController {
  RxBool eventsListLoading = false.obs;
  List<EventInfoModel> eventlist = [];
  RxList<EventInfoModel> tempEventList = RxList();

  Future<bool> createEvent(Map<String, dynamic> map) async {
    try {
      showLoader();

      var data = await BackendRepo().createEvent(
        data: map,
      );
      if (data.message != null) {
        showSuccessSnackBar(data.message!);
      }
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

  Future<EventInfoModel?> updateEvent(
      Map<String, dynamic> map, String eventId) async {
    try {
      showLoader();

      var data = await BackendRepo().updateEvent(data: map, eventId: eventId);
      if (data.message != null) {
        showSuccessSnackBar(data.message!);
      }
      hideLoader();
      return data.info;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<EventDetailModel?> addInvitee(
      Map<String, dynamic> map, String id) async {
    try {
      showLoader();

      var data = await BackendRepo().addInvitee(data: map, id: id);
      if (data?.message != null) {
        showSuccessSnackBar(data?.message ?? '');
      }
      hideLoader();
      return data;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<bool> deleteEvent(String id) async {
    try {
      showLoader();

      var data = await BackendRepo().deleteEvent(
        id: id,
      );
      if (data.message != null) {
        showSuccessSnackBar(data.message!);
      }
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

  Future<EventInfoModel?> updateClosedEvent(
      Map<String, dynamic> map, String eventId, String? imagePath) async {
    try {
      showLoader();

      var data = await BackendRepo().updateClosedEvent(
          map: map, nameImagePath: imagePath, eventId: eventId);
      if (data.message != null) {
        showSuccessSnackBar(data.message!);
      }
      hideLoader();
      return data.info;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<bool> getEventsList() async {
    try {
      eventlist.clear();
      eventsListLoading.value = true;
      var result = await BackendRepo().getEventList();
      eventlist = result.info ?? [];
      tempEventList.value = eventlist;
      eventsListLoading.value = false;

      return true;
    } on InternetException {
      eventsListLoading.value = false;
      return false;
    } catch (e) {
      eventsListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  executeSearch(String searchedText) {
    tempEventList.value =
        eventlist.map((e) => EventInfoModel.clone(e)).toList();

    tempEventList.value.removeWhere((element) =>
        !element.name!.toLowerCase().contains(searchedText.toLowerCase()));
    tempEventList.refresh();
  }
}

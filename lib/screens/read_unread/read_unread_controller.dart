import 'package:get/get.dart';

import '../../models/plans_model.dart';
import '../../models/read_unread_list_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class ReadUnreadController extends GetxController {



  RxBool messagesLoading = false.obs;
  RxList<ReadUnreadMessageModel> messagesList = RxList();
  RxBool messageListLoading = false.obs;
  ReadUnreadListModel? readUnreadMessageModel = null;



  Future<bool> getMesageList() async {
    try {
      messagesList.clear();
      messageListLoading.value = true;
      readUnreadMessageModel = await BackendRepo().getReadUnread();
      messagesList.value = readUnreadMessageModel!.info?.data ?? [];
      messageListLoading.value = false;
      return true;
    } on InternetException {
      messageListLoading.value = false;
      return false;
    } catch (e) {
      messageListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> getPaginatedMessageList() async {
    try {
      readUnreadMessageModel = await BackendRepo()
          .getReadUnread(path: readUnreadMessageModel!.info!.nextPageUrl!);
      messagesList.value.addAll(readUnreadMessageModel!.info?.data ?? []);
      messageListLoading.value = false;
      messagesList.refresh();
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      showErrorSnackBar(e.toString());

      return false;
    }
  }











}

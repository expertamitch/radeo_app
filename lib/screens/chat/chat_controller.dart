import 'dart:io';

import 'package:get/get.dart';
import 'package:redeo/widgets/loader.dart';

import '../../models/chat_history_model.dart';
import '../../models/chat_list_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class ChatController extends GetxController {
  RxList<ChatListItem> chatList = RxList();
  RxBool chatsLoading = false.obs;

  RxList<MessageItemData> messagesList = RxList();

  Future<bool> getChatList() async {
    try {
      chatList.clear();
      chatsLoading.value = true;
      var model = await BackendRepo().getChatList();

      chatList.value = model.info ?? [];
      chatsLoading.value = false;
      return true;
    } on InternetException {
      chatsLoading.value = false;
      return false;
    } catch (e) {
      chatsLoading.value = false;
      showErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<bool> getChatHistory(String uid, {bool loader = true}) async {
    try {
      if (loader) showLoader();
      var model = await BackendRepo().getChatHistory(uid);
      messagesList.clear();
      messagesList.addAll(model.info ?? []);
      messagesList.refresh();

      if (loader) hideLoader();

      return true;
    } on InternetException {
      if (loader) hideLoader();
      return false;
    } catch (e) {
      if (loader) hideLoader();

      showErrorSnackBar(e.toString());

      return false;
    }
  }


  Future<bool> refreshChat(String uid, {bool loader = true}) async {
    try {
      var model = await BackendRepo().getChatHistory(uid);
      messagesList.clear();
      messagesList.addAll(model.info ?? []);
      messagesList.refresh();


      return true;
    } on InternetException {
      return false;
    } catch (e) {

      showErrorSnackBar(e.toString());

      return false;
    }
  }


  Future<bool> sendMessage({
    String? path,
    String? message,
    bool? shouldShowLoader,
    required String? messageType,
    required String? forUser,
  }) async {
    if(shouldShowLoader==null)
      shouldShowLoader=true;
    try {

      if(shouldShowLoader) {
        await Future.delayed(Duration(seconds: 1));

        showLoader();
      }

      List<int>? bytes;

      if (path != null) bytes = await File(path).readAsBytes();

       await BackendRepo().sendMessage(
          forUser: forUser,
          messageType: messageType,
          bytes: bytes,
          message: message);
      if(shouldShowLoader)
      hideLoader();


      return true;
    } on InternetException {
      if(shouldShowLoader)
      hideLoader();

      return false;
    } catch (e) {
      if(shouldShowLoader)
      hideLoader();

      showErrorSnackBar(e.toString());

      return false;
    }
  }
}

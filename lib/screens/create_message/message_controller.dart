import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/loader.dart';

import '../../models/create_message_request_model.dart';
import '../../models/custom_message_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class MessageController extends GetxController {
  RxList<CustomMessage> customMessageList = RxList();
  RxList<CustomMessage> audioMessageList = RxList();
  RxList<CustomMessage> videoMessageList = RxList();
  RxList<CustomMessage> textMessageList = RxList();

  String qrResult = '';
  TextEditingController locationController = TextEditingController();
  bool response = false;

  String attachmentFile = '';
  String? selectedMessageType; //Text, Audio, Video
  int? selectedMessageId; //Text, Audio, Video
  String selectedResponseType = 'Custom'; //Open, Custom

  reset() {
    qrResult = '';
    locationController.text = '';
    response = false;

    attachmentFile = '';
    selectedMessageType = null;
    selectedMessageId = null;
    selectedResponseType = 'Custom';

  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    await getCustomMessages();
    await getAudioMessages();
    await getVideoMessages();
    await getTextMessages();
  }

  Future<bool> getCustomMessages() async {
    try {
      customMessageList.clear();
      var data = await BackendRepo().getCustomMessage('checkbox');
      if (data.info != null && data.info!.customMessages != null) {
        customMessageList.value = data.info!.customMessages!;
      }
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAudioMessages() async {
    try {
      audioMessageList.clear();
      var data = await BackendRepo().getCustomMessage('audio');
      if (data.info != null && data.info!.customMessages != null) {
        audioMessageList.value = data.info!.customMessages!;
      }
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getVideoMessages() async {
    try {
      videoMessageList.clear();
      var data = await BackendRepo().getCustomMessage('video');
      if (data.info != null && data.info!.customMessages != null) {
        videoMessageList.value = data.info!.customMessages!;
      }
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getTextMessages() async {
    try {
      textMessageList.clear();
      var data = await BackendRepo().getCustomMessage('text');
      if (data.info != null && data.info!.customMessages != null) {
        textMessageList.value = data.info!.customMessages!;
      }
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveCustomMessage(String message) async {
    try {
      showLoader();

      var data = await BackendRepo().createCustomMessage(message);
      if (data.info != null) {
        customMessageList.value.add(data.info!);
        customMessageList.refresh();
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

  Future<int?> saveTextMessage(String message, String title) async {
    try {
      showLoader();

      var data = await BackendRepo().createTextMessage(message, title);
      if (data.info != null) {
        textMessageList.value.add(data.info!);
        textMessageList.refresh();
      }
      hideLoader();
      return data.info?.id ?? null;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<int?> saveVideoMessage(
      {required String videoPath,
      required String title,
      required String thumbnailPath}) async {
    try {
      showLoader();
      var videoBytes = await File(videoPath).readAsBytes();
      var thumbNailBytes = await File(thumbnailPath).readAsBytes();

      var data = await BackendRepo().createVideoMessage(
          videoBytes: videoBytes,
          title: title,
          thumbNailBytes: thumbNailBytes,
          tName: thumbnailPath.split('.').last);
      if (data.info != null) {
        videoMessageList.value.add(data.info!);
        videoMessageList.value.forEach((element) {
          element.isSelected = false;
        });
        videoMessageList.value.last.isSelected = true;

        videoMessageList.refresh();
      }
      hideLoader();
      return data.info?.id ?? null;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<int?> saveAudioMessage(String path, String title) async {
    try {
      showLoader();
      var bytes = await File(path).readAsBytes();
      var data =
          await BackendRepo().createAudioMessage(bytes: bytes, title: title);
      if (data.info != null) {
        audioMessageList.value.add(data.info!);
        audioMessageList.value.forEach((element) {
          element.isSelected = false;
        });
        audioMessageList.value.last.isSelected = true;
        audioMessageList.refresh();
      }
      hideLoader();
      return data.info?.id ?? null;
    } on InternetException {
      hideLoader();
      return null;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());
      return null;
    }
  }

  Future<bool> createMessage(CreateMessageRequestModel model) async {
    try {
      showLoader();

      var data = await BackendRepo().createMessage(model: model);
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

  Future<bool> deleteCustomMessage(int id) async {
    try {
      showLoader();

      await BackendRepo().deleteCustomMessage(id);
      customMessageList.value.removeWhere((element) => element.id == id);
      customMessageList.refresh();

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

  Future<bool> deleteAudioMessage(int id) async {
    try {
      showLoader();

      await BackendRepo().deleteCustomMessage(id);
      audioMessageList.value.removeWhere((element) => element.id == id);
      audioMessageList.refresh();

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

  Future<bool> deleteVideoMessage(int id) async {
    try {
      showLoader();

      await BackendRepo().deleteCustomMessage(id);
      videoMessageList.value.removeWhere((element) => element.id == id);
      videoMessageList.refresh();

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

  Future<bool> deleteTextMessage(int id) async {
    try {
      showLoader();

      await BackendRepo().deleteCustomMessage(id);
      textMessageList.value.removeWhere((element) => element.id == id);
      textMessageList.refresh();

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

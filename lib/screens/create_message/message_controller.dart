import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redeo/widgets/loader.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../models/custom_message_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class MessageController extends GetxController {
  RxList<CustomMessage> customMessageList = RxList();
  RxList<CustomMessage> audioMessageList = RxList();
  RxList<CustomMessage> videoMessageList = RxList();
  RxList<CustomMessage> textMessageList = RxList();

  String? selectedMessageType; //Text, Audio, Video

  String selectedResponseType = 'Custom'; //Open, Custom

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
        generateVideoThumbnail();
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

  Future<bool> saveVideoMessage(String path) async {
    try {
      showLoader();
      var bytes = await File(path).readAsBytes();

      var data =
          await BackendRepo().createVideoMessage(bytes: bytes, fileName: path);
      if (data.info != null) {
        videoMessageList.value.add(data.info!);
        videoMessageList.value.forEach((element) {
          element.isSelected = false;
        });
        videoMessageList.value.last.isSelected = true;

        final fileName = await VideoThumbnail.thumbnailFile(
          video: BackendRepo.baseUrl + videoMessageList.value.last.file!,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxHeight: 64,
          // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          quality: 75,
        );
        if (fileName != null)
          videoMessageList.value.last.thumbnail = File(fileName);

        videoMessageList.refresh();
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

  Future<bool> saveAudioMessage(String path) async {
    try {
      showLoader();
      var bytes = await File(path).readAsBytes();
      var data =
      await BackendRepo().createAudioMessage(bytes: bytes, fileName: path);
      if (data.info != null) {
        audioMessageList.value.add(data.info!);
        audioMessageList.value.forEach((element) {
          element.isSelected = false;
        });
        audioMessageList.value.last.isSelected = true;
        audioMessageList.refresh();
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

  generateVideoThumbnail() {
    videoMessageList.value.forEach((element) async {
      if (element.thumbnail == null) {
        final fileName = await VideoThumbnail.thumbnailFile(
          video: BackendRepo.baseUrl + element.file!,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxHeight: 64,
          // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          quality: 75,
        );
        if (fileName != null) element.thumbnail = File(fileName);
      }
    });
  }
}

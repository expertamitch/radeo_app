import 'dart:io';

import 'package:dio/dio.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/models/chat_history_model.dart';
import 'package:redeo/models/chat_list_model.dart';
import 'package:redeo/models/custom_message_model.dart';
import 'package:redeo/models/dnc_list_response_model.dart';
import 'package:redeo/models/events_model.dart';
import 'package:redeo/models/field_log_model.dart';
import 'package:redeo/models/message_only_model.dart';
import 'package:redeo/models/register_model.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/models/timer_model.dart';
import 'package:redeo/models/update_event_model.dart';

import '../../models/add_custom_message_model.dart';
import '../../models/all_redeo_member_list_response_model.dart';
import '../../models/create_contact_model.dart';
import '../../models/create_message_request_model.dart';
import '../../models/event_detail_model.dart';
import '../../models/reports_model.dart';
import '../../models/return_history_model.dart';
import '../../models/territory_detail_model.dart';
import '../../models/territory_list_model.dart';
import '../api_exception.dart';
import '../api_utils.dart';
import '../internet_exception.dart';
import '../storage_utils.dart';

class BackendRepo {
  static String baseUrl = "https://myredeo.com/api/";
  static String storageUrl = "https://myredeo.com/storage/";

  Future<RegisterModel> createAccount(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}register";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<RegisterModel> verifyMobileNumber(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}verify-user";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<RegisterModel> resendOTP({required Map<String, dynamic> data}) async {
    String url = "${baseUrl}resend-otp";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<RegisterModel> forgotPassword(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}forgot-password-request";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<RegisterModel> resetPassword(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}forgot-password-update";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<RegisterModel> login({required Map<String, dynamic> data}) async {
    String url = "${baseUrl}login";
    try {
      final response = await apiUtils.post(
          url: url, data: data, options: getOptions(addAuth: false));
      var model = RegisterModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AllGroupListResponseModel> getGroupList() async {
    String url = "${baseUrl}user/group";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = AllGroupListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AllRedeoMemberListResponseModel> getRedeoMemberList() async {
    String url = "${baseUrl}user/redeo-members";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = AllRedeoMemberListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AllGroupListResponseModel> getAllGroupList() async {
    String url = "${baseUrl}user/groups-members";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = AllGroupListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<DNCListModel> getDNCList() async {
    String url = "${baseUrl}user/do-not-call";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = DNCListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> createGroup(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/group";
    try {
      final response =
          await apiUtils.post(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> deleteGroup(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/group";
    try {
      final response =
          await apiUtils.delete(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TerritoryListModel> getTerritoryList() async {
    String url = "${baseUrl}user/territory";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TerritoryListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TerritoryListModel> getAssignedTerritoryList() async {
    String url = "${baseUrl}user/do-not-call/territory";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TerritoryListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TerritoryDetailModel> getTerritoryDetail(int id) async {
    String url = "${baseUrl}user/territory/$id";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TerritoryDetailModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> assignTerritory(
      {required String id, required String assigned_to}) async {
    String url =
        "${baseUrl}user/territory/assign?id=$id&assigned_to=$assigned_to";
    try {
      final response = await apiUtils.put(url: url, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> updateTerritory(
      {required String id, required String status}) async {
    String url = "${baseUrl}user/territory/status?id=$id&status=$status";
    try {
      final response = await apiUtils.put(url: url, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TerritoryListModel> getTerritoryHistory() async {
    String url = "${baseUrl}user/territory/history";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TerritoryListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<CustomMessageModel> getCustomMessage(String type) async {
    String url = "${baseUrl}user/custom-reponse?type=$type";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = CustomMessageModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AddCustomMessageModel> createCustomMessage(String name) async {
    var data = {"type": "checkbox", "content": name};

    String url = "${baseUrl}user/custom-reponse";
    try {
      final response =
          await apiUtils.post(url: url, options: getOptions(), data: data);
      var model = AddCustomMessageModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> addDNC(
      {required String territoryId,
      required String address,
      required String reason}) async {
    var data = {
      "territory_id": territoryId,
      "address": address,
      "reason": reason
    };

    String url = "${baseUrl}user/do-not-call";
    try {
      final response =
          await apiUtils.post(url: url, options: getOptions(), data: data);
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AddCustomMessageModel> createTextMessage(
      String name, String title) async {
    var data = {"type": "text", "content": name, 'title': title};

    String url = "${baseUrl}user/custom-reponse";
    try {
      final response =
          await apiUtils.post(url: url, options: getOptions(), data: data);
      var model = AddCustomMessageModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AddCustomMessageModel> createVideoMessage(
      {required List<int> videoBytes,
      required List<int> thumbNailBytes,
      required String tName,
      required String title}) async {
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        videoBytes,
        filename: '${DateTime.now().microsecondsSinceEpoch}.${title}',
      ),
      'thumbnail': MultipartFile.fromBytes(
        thumbNailBytes,
        filename: '${DateTime.now().microsecondsSinceEpoch}.${tName}',
      ),
      'title': title,
      'type': 'video',
      'content': '',
    });

    String url = "${baseUrl}user/custom-reponse";
    try {
      final response = await apiUtils.postWithProgress(
          url: url, options: getOptions(), data: formData);
      var model = AddCustomMessageModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<AddCustomMessageModel> createAudioMessage(
      {required List<int> bytes, required String title}) async {
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes,
        filename: title,
      ),
      'type': 'audio',
      'title': title,
      'content': '',
    });

    String url = "${baseUrl}user/custom-reponse";
    try {
      final response = await apiUtils.postWithProgress(
          url: url, options: getOptions(), data: formData);
      var model = AddCustomMessageModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> createMessage(
      {required CreateMessageRequestModel model}) async {
    // var bytes = await File(path).readAsBytes();

    Map<String, dynamic> map = {};

    map = {
      'location': model.location,
      'message_id': model.selectedMessageId,
      'qr_code_id': model.qrResult
    };

    if (model.response) map['response_type'] = model.selectedResponseType;
    if (model.response &&
        model.selectedResponseType!.toLowerCase() == 'custom') {
      for (int i = 0; i < model.selectedCustomResponseId.length; i++) {
        map['responses[${i}]'] = model.selectedCustomResponseId[i];
      }
    }

    if (model.attachmentFile != null && model.attachmentFile!.isNotEmpty) {
      var bytes = await File(model.attachmentFile!).readAsBytes();

      map['attachments[]'] = MultipartFile.fromBytes(
        bytes,
        filename:
            '${DateTime.now().microsecondsSinceEpoch}.${model.attachmentFile!.split('/').last}',
      );
    }

    var formData = FormData.fromMap(map);

    String url = "${baseUrl}user/message";
    try {
      final response = await apiUtils.postWithProgress(
          url: url, options: getOptions(), data: formData);
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> deleteCustomMessage(int id) async {
    String url = "${baseUrl}user/custom-reponse/$id";
    try {
      final response = await apiUtils.delete(url: url, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> editGroup(
      {required Map<String, dynamic> data, required String id}) async {
    String url = "${baseUrl}user/group/$id";
    try {
      final response =
          await apiUtils.put(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> createReturn(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/return";
    try {
      final response =
          await apiUtils.post(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> createEvent(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/event";
    try {
      final response =
          await apiUtils.post(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<UpdateEventModel> updateEvent(
      {required Map<String, dynamic> data, required String eventId}) async {
    String url = "${baseUrl}user/event/$eventId";
    try {
      final response =
          await apiUtils.get(url: url, data: data, options: getOptions());
      var model = UpdateEventModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<EventDetailModel?> addInvitee(
      {required Map<String, dynamic> data, required String id}) async {
    String url = "${baseUrl}user/event/invitee/$id";
    try {
      final response =
          await apiUtils.put(url: url, data: data, options: getOptions());
      var model = EventDetailModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> deleteEvent({required String id}) async {
    String url = "${baseUrl}user/event/$id";
    try {
      final response = await apiUtils.delete(url: url, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<EventsModel> getEventList() async {
    String url = "${baseUrl}user/event";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = EventsModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> createNOE(
      {required Map<String, dynamic> map,
      required String nameImagePath,
      required String attachmentPath}) async {
    var bytes = await File(nameImagePath).readAsBytes();
    map['name_image'] = MultipartFile.fromBytes(
      bytes,
      filename:
          '${DateTime.now().microsecondsSinceEpoch}.${nameImagePath.split('/').last}',
    );

    var bytes1 = await File(attachmentPath).readAsBytes();
    map['attachments[]'] = MultipartFile.fromBytes(
      bytes1,
      filename:
          '${DateTime.now().microsecondsSinceEpoch}.${attachmentPath.split('/').last}',
    );

    var formData = FormData.fromMap(map);

    String url = "${baseUrl}user/noe";
    try {
      final response = await apiUtils.postWithProgress(
          url: url, options: getOptions(), data: formData);
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<UpdateEventModel> updateClosedEvent({
    required Map<String, dynamic> map,
    String? nameImagePath,
    required String eventId,
  }) async {
    if (nameImagePath != null) {
      var bytes = await File(nameImagePath).readAsBytes();
      map['image'] = MultipartFile.fromBytes(
        bytes,
        filename:
            '${DateTime.now().microsecondsSinceEpoch}.${nameImagePath.split('/').last}',
      );
    }

    var formData = FormData.fromMap(map);

    String url = "${baseUrl}user/event/request/$eventId";
    try {
      final response = await apiUtils.postWithProgress(
          url: url, options: getOptions(), data: formData);
      return UpdateEventModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ReturnVisitListModel> getNOEList({String? path}) async {
    String url = path ?? "${baseUrl}user/return";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = ReturnVisitListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ChatListModel> getChatList() async {
    String url = "${baseUrl}user/chat/users";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = ChatListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ChatHistoryModel> getChatHistory(String uid) async {
    String url = "${baseUrl}user/chat/history?for_user=$uid";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = ChatHistoryModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ReturnVisitListModel> getIncompleteNOEList({String? path}) async {
    String url = path ?? "${baseUrl}user/return/incomplete";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = ReturnVisitListModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ReturnHistoryModel> getReturnHistory(String id) async {
    String url = "${baseUrl}user/return/$id";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = ReturnHistoryModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<FieldLogModel> getFieldLog(String date) async {
    String url = "${baseUrl}user/field-logs?date=$date";
    try {
      final response = await apiUtils.get(
        url: url,
        options: getOptions(),
      );
      var model = FieldLogModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> sendQr(String id) async {
    String url = "${baseUrl}user/scan";

    var map = {"qr_code_id": id};

    try {
      final response =
          await apiUtils.put(url: url, options: getOptions(), data: map);
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TimerModel?> getTimer() async {
    String url = "${baseUrl}user/timer";

    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TimerModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<TimerModel?> postTimer({
    required Map<String, dynamic> map,
  }) async {
    String url = "${baseUrl}user/timer";

    try {
      final response =
          await apiUtils.post(url: url, options: getOptions(), data: map);
      var model = TimerModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> sendMessage({
    List<int>? bytes,
    String? message,
    required String? messageType,
    required String? forUser,
  }) async {
    if (bytes == null) {
      var formData = {
        'message': message ?? '',
        'for_user': forUser,
        'message_type': messageType,
      };

      String url = "${baseUrl}user/chat";
      try {
        final response = await apiUtils.post(
            url: url, options: getOptions(), data: formData);
        var model = MessageOnlyModel.fromJson(response.data);
        return model;
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.unknown) {
          throw InternetException();
        }
        throw ApiException(apiUtils.handleError(e));
      }
    } else {
      var formData = FormData.fromMap({
        'file': bytes == null
            ? null
            : MultipartFile.fromBytes(
                bytes,
                filename: '${DateTime.now().microsecondsSinceEpoch}.${title}',
              ),
        'message': message ?? '',
        'for_user': forUser,
        'message_type': messageType,
      });

      String url = "${baseUrl}user/chat";
      try {
        final response = await apiUtils.postWithProgress(
            url: url, options: getOptions(), data: formData);
        var model = MessageOnlyModel.fromJson(response.data);
        return model;
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.unknown) {
          throw InternetException();
        }
        throw ApiException(apiUtils.handleError(e));
      }
    }
  }

  Future<CreateContactModel> createContact(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/contacts";
    try {
      final response =
          await apiUtils.post(url: url, data: data, options: getOptions());
      var model = CreateContactModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<CreateContactModel> editContact(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/contacts";
    try {
      final response =
          await apiUtils.put(url: url, data: data, options: getOptions());
      var model = CreateContactModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> updateReports(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/report";
    try {
      final response =
          await apiUtils.put(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<ReportsModel> getReport(String date) async {
    String url = "${baseUrl}user/report?date=$date";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = ReportsModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> validateQRCode(Map<String, dynamic> data) async {
    String url = "${baseUrl}user/verify-qr";
    try {
      final response =
          await apiUtils.get(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel> saveFirebaseToken(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}user/token";
    try {
      final response =
          await apiUtils.post(url: url, data: data, options: getOptions());
      var model = MessageOnlyModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Future<MessageOnlyModel?> getPlans() async {
    String url = "${baseUrl}user/plan";

    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = TimerModel.fromJson(response.data);
      return MessageOnlyModel();
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }

  Options getOptions({bool addAuth = true}) {
    Options? options = Options();
    options.headers = {};
    options.headers!["Accept"] = "application/json";
    if (addAuth)
      options.headers!["Authorization"] = "Bearer ${StorageUtils.getToken()}";
    return options;
  }
}

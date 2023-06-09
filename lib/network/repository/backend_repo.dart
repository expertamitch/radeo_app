import 'package:dio/dio.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/models/custom_message_model.dart';
import 'package:redeo/models/dnc_list_response_model.dart';
import 'package:redeo/models/message_only_model.dart';
import 'package:redeo/models/register_model.dart';

import '../../models/add_custom_message_model.dart';
import '../../models/all_redeo_member_list_response_model.dart';
import '../../models/territory_detail_model.dart';
import '../../models/territory_list_model.dart';
import '../api_exception.dart';
import '../api_utils.dart';
import '../internet_exception.dart';
import '../storage_utils.dart';

class BackendRepo {
  static String baseUrl = "http://18.170.57.130/api/";
  static String storageUrl = "http://18.170.57.130/storage/";

  Future<RegisterModel> createAccount(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}register";
    try {
      final response = await apiUtils.post(
        url: url,
        data: data,
        options: getOptions(addAuth: false)
      );
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
        url: url,
        data: data,options: getOptions(addAuth: false)
      );
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
        url: url,
        data: data,options: getOptions(addAuth: false)
      );
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
        url: url,
        data: data,options: getOptions(addAuth: false)
      );
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
        url: url,
        data: data,options: getOptions(addAuth: false)
      );
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
        url: url,
        data: data,options: getOptions(addAuth: false)
      );
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

  Future<DNCListResponseModel> getDNCList() async {
    String url = "${baseUrl}user/do-not-call";
    try {
      final response = await apiUtils.get(url: url, options: getOptions());
      var model = DNCListResponseModel.fromJson(response.data);
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

  Future<TerritoryDetailModel> getTerritoryDetail(String id) async {
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

  Future<AddCustomMessageModel> createVideoMessage(
      {required List<int> bytes, required String fileName}) async {
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes,
        filename:
            '${DateTime.now().microsecondsSinceEpoch}.${fileName.split('.').last}',
      ),
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
      {required List<int> bytes, required String fileName}) async {
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        bytes,
        filename:
        '${DateTime.now().microsecondsSinceEpoch}.${fileName.split('.').last}',
      ),
      'type': 'audio',
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

  Options getOptions({bool addAuth=true}) {
    Options? options = Options();
    options.headers = {};
    options.headers!["Accept"] = "application/json";
    if(addAuth)
    options.headers!["Authorization"] = "Bearer ${StorageUtils.getToken()}";
    return options;
  }
}

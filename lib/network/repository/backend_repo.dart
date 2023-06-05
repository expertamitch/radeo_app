import 'package:dio/dio.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/models/dnc_list_response_model.dart';
 import 'package:redeo/models/register_model.dart';

import '../api_exception.dart';
import '../api_utils.dart';
import '../internet_exception.dart';
import '../storage_utils.dart';

class BackendRepo {
  static String baseUrl = "http://18.170.57.130/api/";

  Future<RegisterModel> createAccount(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}register";
    try {
      final response = await apiUtils.post(
        url: url,
        data: data,
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

  Future<RegisterModel> login(
      {required Map<String, dynamic> data}) async {
    String url = "${baseUrl}login";
    try {
      final response = await apiUtils.post(
        url: url,
        data: data,
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


  Future<AllGroupListResponseModel> getGroupList(
      ) async {
    String url = "${baseUrl}user/group";
    try {
      final response = await apiUtils.get(
        url: url,options: getOptions()
       );
      var model = AllGroupListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }


  Future<DNCListResponseModel> getDNCList(
      ) async {
    String url = "${baseUrl}user/do-not-call";
    try {
      final response = await apiUtils.get(
          url: url,options: getOptions()
      );
      var model = DNCListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.unknown) {
        throw InternetException();
      }
      throw ApiException(apiUtils.handleError(e));
    }
  }





  Options getOptions() {
    Options? options = Options();
    options.headers = {};
    options.headers!["Authorization"] = "Bearer ${StorageUtils.getToken()}";
    return options;
  }
}

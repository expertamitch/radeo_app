import 'package:dio/dio.dart';

import '../api_utils.dart';
import '../internet_exception.dart';
import '../storage_utils.dart';

class BackendRepo {
  static String baseUrl = "https://demo.mobisprint.com:4006/v1/customers/";

  // Future<CreateAccountModel> createAccount(
  //     {required Map<String, dynamic> data}) async {
  //   String url = "${baseUrl}create-account/request-otp";
  //
  //   try {
  //     final response =
  //         await apiUtils.post(url: url, data: data, options: getOptions(false));
  //     var model = CreateAccountModel.fromJson(response.data);
  //     return model;
  //   } catch (e) {
  //     if (e is DioError && e.type == DioErrorType.unknown) {
  //       throw InternetException();
  //     }
  //     throw ApiException(apiUtils.handleError(e));
  //   }
  // }
  //
  //
  // Options getOptions(bool isBearer) {
  //   Options? options = Options();
  //   options.headers = {};
  //   options.headers!["Authorization"] = isBearer
  //       ? "Bearer " + StorageUtils.getToken()!
  //       : "Basic YWtvcm46YWtvcm4=";
  //   return options;
  // }
}

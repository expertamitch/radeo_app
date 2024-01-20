 import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

 import '../utils/log_util.dart';
import 'custom_log_interceptor.dart';

final title = "ApiUtils";

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio();

  ApiUtils._i() {
    _dio.interceptors.add(CustomLogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await _dio.get(
      url,
      queryParameters: queryParameters,data: data,
      options: options,
    );
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // FocusManager.instance.primaryFocus?.unfocus();
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> patch({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await _dio.delete(
      url,
      queryParameters: queryParameters,data: data,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    Log.loga(title, "handleError:: error >> $error");

    if (error is DioError) {
      Log.loga(
          title, '************************ DioError ************************');

      DioError dioError = error as DioError;
      Log.loga(title, 'dioError:: $dioError');

      switch (dioError.type) {
        case DioErrorType.unknown:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.badResponse:
          {
            if (dioError.response?.data["description"] != null) {
              errorDescription = dioError.response?.data["description"];
            } else if (dioError.response?.data["error_description"] != null) {
              errorDescription = dioError.response?.data["error_description"];
            } else if (dioError.response?.data["message"] != null) {
              errorDescription = dioError.response?.data["message"];
            }
          }

          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = error;
    }
    Log.loga(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }
}

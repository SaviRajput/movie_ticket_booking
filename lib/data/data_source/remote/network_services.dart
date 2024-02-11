import 'dart:developer';

import 'package:book_my_movie/utils/common/constants.dart';
import 'package:dio/dio.dart';

import '../../../utils/common/exports.dart';

class NetworkServices {
  late String baseUrl;
  final Dio _dio = Dio();

  NetworkServices() {
    // init base Url from App
    _dio.options = BaseOptions(
        receiveTimeout: const Duration(milliseconds: 50000),
        connectTimeout: const Duration(milliseconds: 50000),
        contentType: "application/json");
    baseUrl = Constants.baseUrl;
    // _dio.interceptors.add(PrettyDioLogger(request: true,compact: true,requestBody: true,));
  }

  Future<Response?>? commonGetMethod(String path,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? query,
      BuildContext? context}) async {
    try {
      Response response = await _dio.get(baseUrl + path,
          options: Options(headers: headers ?? {}),
          queryParameters: query ?? {});
      if (response.statusCode != null && response.statusCode! == 200) {
        return response;
      } else {
        return null;
      }
    } catch (error) {
      log("ERROR: ${error.toString()}");
      if (context != null) {}

      return null;
    }
  }

  Future<Response?>? commonPostMethod(String path,
      {Map<String, dynamic>? headers,
      var data,
      BuildContext? context,
      String? customErrorMessage,
      String? customHeaderMessage}) async {
    try {
      Response response = await _dio.post(baseUrl + path,
          options: headers != null ? Options(headers: headers) : Options(),
          data: data);
      if (response.statusCode! == 200) {
        return response;
      } else {
        if (context != null) {}

        log("Status Code : ${response.statusCode ?? "null"}");
        return null;
      }
    } catch (error) {
      log("ERROR: ${error.toString()}");

      return null;
    }
  }
}

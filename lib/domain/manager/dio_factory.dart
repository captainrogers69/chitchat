import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_config.dart';
import 'dio_error.dart';
import 'dio_log_intercepter.dart';

// typedef OnDioError = void Function(DioErrorResponse);

enum DioAPIException { unauthorized, notfound, connectionfailed, other }

typedef OnDioResponse<Response> = void Function(
    Response? response, DioErrorResponse error);

class DioFactory {
  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;
  // static var _authorization = '';
  // static void initialiseHeaders(String token) {
  //   if (token == "") {
  //     _authorization = "";
  //   } else {
  //     _authorization = 'Bearer $token';
  //   }
  //   dio!.options.headers[HttpHeaders.authorizationHeader] = _authorization;
  // }

  Dio? _dio;

  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
        //TODO: production environment
        baseUrl: /*  kDebugMode
            ? "https://stage.api.digitaldocsys.in/"
            : */
            'https://api.digitaldocsys.in/',
        // baseUrl: "",
        // baseUrl: 'https://api.digitaldocsys.in/',
        headers: {
          // HttpHeaders.authorizationHeader: _authorization,
          HttpHeaders.contentTypeHeader: "application/json"
        },
      ),
    );
    if (!kReleaseMode) {
      _dio!.interceptors.add(
        DioLogInterceptor(
          request: DioConfig.logNetworkRequest,
          requestHeader: DioConfig.logNetworkRequestHeader,
          requestBody: DioConfig.logNetworkRequestBody,
          responseHeader: DioConfig.logNetworkResponseHeader,
          responseBody: DioConfig.logNetworkResponseBody,
          error: DioConfig.logNetworkError,
        ),
      );
    }
  }
}

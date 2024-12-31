import 'dart:developer';

import 'package:chitchat/app/chat_app.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dio_error.dart';
import 'dio_factory.dart';
import 'dio_methods.dart';

final dioWrapperProvider = Provider<DioWrapper>((ref) {
  return DioWrapper(ref);
});

class DioWrapper {
  final Ref _ref;
  DioWrapper(this._ref);
  // static DioWrapper instance = DioWrapper(ref);

  Future<void> request(
      {Map<String, dynamic>? params,
      // FormData? formdata,
      bool hideLoadingIndicator = false,
      DioMethod method = DioMethod.getr,
      required OnDioResponse onResponse,
      Map<String, dynamic>? headers,
      required String endPoint}) async {
    Map<String, dynamic> dioHeaders = headers ?? {};
    // dioHeaders[HttpHeaders.contentTypeHeader] = "application/json";

    try {
      Response response;
      switch (method) {
        case DioMethod.post:
          response = await DioFactory.dio!.post(endPoint,
              options: Options(
                headers: dioHeaders,
              ),
              data: params
              // data: formdata ?? params,
              );
          break;
        case DioMethod.delete:
          response = await DioFactory.dio!.delete(
            endPoint,
            data: params,
            options: Options(
              headers: dioHeaders,
            ),
          );
          break;
        case DioMethod.getr:
          response = await DioFactory.dio!.get(
            endPoint,
            queryParameters: params,
            options: Options(
              headers: dioHeaders,
            ),
          );
          break;
        case DioMethod.patch:
          response = await DioFactory.dio!.patch(
            endPoint,
            data: params,
            //   data: formdata ?? params,
            options: Options(
              headers: dioHeaders,
            ),
          );
          break;
        case DioMethod.put:
          response = await DioFactory.dio!.put(
            endPoint,
            data: params,
            // data: formdata ?? params,
            options: Options(
              headers: headers,
            ),
          );
          break;
      }
      onResponse(
        response.data,
        DioErrorResponse(
          error: ErrorResponse(
            message: "",
            status: 0,
          ),
        ),
      );
      // } on DioException catch (e, st) {
      //   if (e.response != null) {
      //     log('Stacktrace : $st', name: "Dio Wrapper Stacktrace");
      //     catchException(e, onResponse: onResponse);
      //   }
    } catch (e) {
      log('Error message : $e', name: "Dio Wrapper Error");
      catchException(e, onResponse: onResponse);
    }
  }

  catchException(e,
      {required void Function(dynamic, DioErrorResponse) onResponse}) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionError) {
        _ref.read(snackKeyProvider).currentState!.showSnackBar(
              snackbarcontent(
                "No Internet Connection",
                error: true,
              ),
            );
        onResponse(
          null,
          DioErrorResponse(
            error: ErrorResponse(
              message: "No Internet Connection",
              status: 1,
            ),
          ),
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        onResponse(
          null,
          DioErrorResponse(
            error: ErrorResponse(
              message: "Server unreachable",
              status: 1,
            ),
          ),
        );
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response!.statusCode == 401) {
          onResponse(
            null,
            DioErrorResponse(
              error: ErrorResponse(
                message: e.response!.data['error'].toString(),
                status: 1,
              ),
            ),
          );
          return;
        } else {
          onResponse(
            null,
            DioErrorResponse(
              error: ErrorResponse(
                message: (e.response!.data?['msg'] ?? 'Something').toString(),
                status: 1,
              ),
            ),
          );
        }
      } else {
        onResponse(
          null,
          DioErrorResponse(
            error: ErrorResponse(
              message: "Request cancelled",
              status: 1,
            ),
          ),
        );
      }
    } else {
      onResponse(
        null,
        DioErrorResponse(
          error: ErrorResponse(
            message: "Something went wrong! Please try again.",
            status: 1,
          ),
        ),
      );
    }
  }
}

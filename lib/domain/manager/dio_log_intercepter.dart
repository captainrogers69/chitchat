import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioLogInterceptor extends Interceptor {
  final bool? request,
      requestHeader,
      requestBody,
      responseHeader,
      responseBody,
      error;

  DioLogInterceptor(
      {this.request,
      this.requestHeader,
      this.requestBody,
      this.responseHeader,
      this.responseBody,
      this.error});

  String cURLRepresentation(RequestOptions options) {
    List<String> components = ["curl -i"];
    if (options.method.toUpperCase() == "GET") {
      components.add("-X ${options.method}");
    }

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    var data = json.encode(options.data);
    data = data.replaceAll('\'', '');
    components.add("-d \"$data\"");

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('*** Response Start ***', name: 'Dio');
    log(response.toString(), name: 'Dio Response');
    log('*** Response End ***', name: 'Dio');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error!) {
      log('*** DioError Start ***:', name: 'Dio');
      log('uri: ${err.requestOptions.uri}', name: 'Dio');
      log('$err', name: 'Dio');
      if (err.response != null) {
        // log('${err.response!}', name: "Dio Exception");
      }
      log('*** DioError End ***', name: "Dio");
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('================================ \n \n');
    log(
        """Curl REQUEST:\n
    ${cURLRepresentation(options)}\n
    """
        "\n================================ \n \n",
        name: "Curl REQUEST");
    handler.next(options);
  }
}

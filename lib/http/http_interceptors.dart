import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_common/utils/log.dart';

import 'http_exception.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // error统一处理
    HttpDioException appException = HttpDioException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;
    handler.reject(err);
  }

}

class LoggerInterceptor extends LogInterceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.i(
        "\n ---------Start Http Request---------\n"
            "Request_BaseUrl  :${options.baseUrl}\n"
            "Request_Path     :${options.path}\n"
            "Request_Method   :${options.method}\n"
            "Request_Headers  :${options.headers}\n"
            "Request_Data     :${options.data}\n"
            "Request_Params   :${options.queryParameters}\n"
            "---------End Http Request---------\n"
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.i(
        "\n---------Start Http Response---------\n"
            "Response_BaseUrl       :${response.realUri}\n"
            "Response_StatusCode    :${response.statusCode}\n"
            "Response_StatusMessage :${response.statusMessage}\n"
            "Response_Headers       :${response.headers.toString()}\n"
            "Response_Data          :${response.data}\n"
            "---------End Http Response---------"
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.i(
        "\n---------Start Http Error---------\n"
            "Error_Type       :${err.type}\n"
            "Error_Error      :${err.error}\n"
            "Error_Message    :${err.message}\n"
            "---------End Http Error---------"
    );
    super.onError(err, handler);
  }

}

/// 响应拦截器【解析数据】
class ResponseParseInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Map<String, dynamic> responseData = response.data ?? Map<String, dynamic>();
    super.onResponse(response, handler);
  }

}


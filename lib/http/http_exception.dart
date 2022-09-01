
import 'package:dio/dio.dart';

import 'http_config.dart';

/// 自定义异常
class HttpDioException implements Exception {

  final int code;
  final String message;
  var error;

  HttpDioException({
    required this.code,
    required this.message
  });

  String toString() {
    return "$code => $message";
  }

  factory HttpDioException.create(DioError error, {HttpExceptionHandler? handler}) {
    HttpDioException exception;
    switch (error.type) {
      case DioErrorType.cancel:
        exception = BadRequestException(HttpErrorType.REQUEST_CANCEL, HttpDescriptionConfig.REQUEST_CANCEL);
        break;

      case DioErrorType.connectTimeout:
        exception = BadRequestException(HttpErrorType.TIMEOUT_CONNECT, HttpDescriptionConfig.TIMEOUT_CONNECT);
        break;

      case DioErrorType.sendTimeout:
        exception = BadRequestException(HttpErrorType.TIMEOUT_REQUEST, HttpDescriptionConfig.TIMEOUT_REQUEST);
        break;

      case DioErrorType.receiveTimeout:
        exception = BadRequestException(HttpErrorType.TIMEOUT_RESPONSE, HttpDescriptionConfig.TIMEOUT_RESPONSE);
        break;

      case DioErrorType.response:
        exception = _handleResponseException(error);
        break;

      default:
        exception = UnknownException(error: error.error);
        break;
    }
    if (handler != null) {
      return handler.handle(exception, exception.code, exception.message);
    } else {
      return exception;
    }
  }

  static HttpDioException _handleResponseException(DioError error) {
    try {
      int errCode = error.response?.statusCode ?? HttpErrorType.UNKNOWN_ERROR;
      switch (errCode) {
        case HttpErrorType.HTTP_BAD_REQUEST:
          return BadRequestException(errCode, HttpDescriptionConfig.HTTP_BAD_REQUEST);
        case HttpErrorType.HTTP_UNAUTHORIZED:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_UNAUTHORIZED);
        case HttpErrorType.HTTP_FORBIDDEN:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_FORBIDDEN);
        case HttpErrorType.HTTP_NOT_FOUND:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_NOT_FOUND);
        case HttpErrorType.HTTP_PROHIBIT:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_PROHIBIT);
        case HttpErrorType.HTTP_SERVER_ERROR:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_SERVER_ERROR);
        case HttpErrorType.HTTP_REQUEST_ERROR:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_REQUEST_ERROR);
        case HttpErrorType.HTTP_SERVER_DOWN:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_SERVER_DOWN);
        case HttpErrorType.HTTP_PROTOCOL_ERROR:
          return UnauthorisedException(errCode, HttpDescriptionConfig.HTTP_PROTOCOL_ERROR);
        case HttpErrorType.UNKNOWN_ERROR:
          return UnknownException();
        default:
          return HttpDioException(
              code: errCode,
              message: error.response?.statusMessage ?? ""
          );
      }
    } on Exception catch (_) {
      return UnknownException();
    }
  }
}

/// 错误码
class HttpErrorType {

  /// http码
  static const int HTTP_SUCCESS = 200;  //响应成功
  static const int HTTP_REQUEST_REDIRECT = 300; //重定向
  static const int HTTP_BAD_REQUEST = 400;  //请求语法错误
  static const int HTTP_UNAUTHORIZED = 401; //没有权限
  static const int HTTP_FORBIDDEN = 403;  //服务器拒绝执行
  static const int HTTP_NOT_FOUND = 404;  //无法连接服务器
  static const int HTTP_PROHIBIT = 405; //请求方法被禁止
  static const int HTTP_SERVER_ERROR = 500; //服务器内部错误
  static const int HTTP_REQUEST_ERROR = 502;  //无效的请求
  static const int HTTP_SERVER_DOWN = 503;  //服务器挂了
  static const int HTTP_PROTOCOL_ERROR = 505; //不支持HTTP协议请求

  /// 请求响应
  static const int UNKNOWN_ERROR = -1;  //未知错误
  static const int REQUEST_CANCEL = 9000; //请求取消
  static const int TIMEOUT_REQUEST = 9001;  //请求超时
  static const int TIMEOUT_CONNECT = 9002;  //连接超时
  static const int TIMEOUT_RESPONSE = 9003; //响应超时
  static const int INTERNET_ERROR = 9004; //网络错误
}

/// 服务器错误
class ServerException extends HttpDioException {
  ServerException(int code, String message)
      : super(code: code, message: message);
}

/// 请求错误
class BadRequestException extends HttpDioException {
  BadRequestException(int code, String message)
      : super(code: code, message: message);
}

/// 未认证异常
class UnauthorisedException extends HttpDioException {
  UnauthorisedException(int code, String message)
      : super(code: code, message: message);
}

/// 未知异常
class UnknownException extends HttpDioException {
  UnknownException({dynamic error}) : super(
      code: HttpErrorType.UNKNOWN_ERROR,
      message: HttpDescriptionConfig.UNKNOWN_ERROR) {
    this.error = error;
  }
}

abstract class HttpExceptionHandler {

  ///
  /// 处理异常
  HttpDioException handle(HttpDioException exception, int code, String message);

}
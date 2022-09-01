

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_common/config/lib_config.dart';

import 'http_config.dart';
import 'http_exception.dart';
import 'http_interceptors.dart';

// https://juejin.cn/post/6844904190838325262#heading-22

/// 网络请求dio封装
class DioHttp {

  factory DioHttp.getInstance() => DioHttp._internal();

  static Function? commonLoading;

  static late Dio _mDio;
  final CancelToken _cancelToken = CancelToken();
  var defaultHost = Host.getHost();

  /// 私有构造
  DioHttp._();

  DioHttp._internal() {
    _mDio = Dio(_config());
    _configProxy();
  }

  Dio getDio() {
    return _mDio;
  }

  BaseOptions _config() {
    return BaseOptions(
      connectTimeout: HttpConfig.CONNECT_TIMEOUT,
      receiveTimeout: HttpConfig.RECEIVE_TIMEOUT,
      contentType: "application/json",
      responseType: ResponseType.json
    );

  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  ///
  /// [connectTimeout] 连接超时赶时间
  ///
  /// [receiveTimeout] 接收超时赶时间
  ///
  /// [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    String? codeLabel, String? messageLabel, String? dataLabel,
    int? serverSuccessCode,
    int? connectTimeout,
    int? receiveTimeout,
    Function? defaultLoading,
    List<Interceptor>? interceptors,
    HttpExceptionHandler? handler
  }) {
    HttpResponseConfig.LABEL_CODE = codeLabel ?? HttpResponseConfig.LABEL_CODE;
    HttpResponseConfig.LABEL_MESSAGE = messageLabel ?? HttpResponseConfig.LABEL_MESSAGE;
    HttpResponseConfig.LABEL_DATA = dataLabel ?? HttpResponseConfig.LABEL_DATA;
    HttpResponseConfig.SERVER_SUCCESS = serverSuccessCode ?? HttpResponseConfig.SERVER_SUCCESS;
    commonLoading = defaultLoading;

    _mDio.options = _mDio.options.copyWith(
      baseUrl: baseUrl ?? defaultHost,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      _mDio.interceptors.addAll(interceptors);
    }
    _mDio.interceptors
      ..add(ErrorInterceptor(handler: handler)) // 添加error拦截器
      ..add(LoggerInterceptor())  // 添加日志拦截器
    ;
  }

  /// 配置代理
  void _configProxy() {
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (HttpProxyConfig.PROXY_ENABLE) {
      (_mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return "PROXY ${HttpProxyConfig.PROXY_IP}:${HttpProxyConfig.PROXY_PORT}";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel(HttpDescriptionConfig.REQUEST_CANCEL_REASON);
  }

  /// 服务请求
  /// [url] 接口地址
  /// [method] 请求方法
  /// [showLoading] 是否显示加载框
  /// [loading] 自定义加载框
  /// [codeLabel] code码的key配置
  /// [messageLabel] message的key配置
  /// [dataLabel] data的key配置
  /// [parameters] 请求参数
  /// [onComplete] 完成回调，成功和失败都会调用
  /// [onSuccess] 成功回调
  /// [onError] 失败回调
  void request(String url, String method, {
    bool showLoading = false, LoadingDialogShow? loading,
    String? codeLabel, String? messageLabel, String? dataLabel,
    Map<String, dynamic>? parameters,
    OnHttpCompleteCallback? onComplete,
    OnHttpSuccessCallback? onSuccess,
    OnHttpErrorCallback? onError
  }) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      //没有网络
      if (connectivityResult == ConnectivityResult.none) {
        String errMsg = HttpDescriptionConfig.NET_ERROR;
        if (onComplete != null) {
          onComplete(
              HttpErrorType.INTERNET_ERROR,
              errMsg,
              null
          );
        }
        if (onError != null) {
          onError(
              HttpErrorType.INTERNET_ERROR,
              errMsg,
              HttpDioException(
                  code: HttpErrorType.INTERNET_ERROR,
                  message: errMsg));
        }
        return;
      }

      loadingShow(showLoading, loading, true);

      Response<dynamic> response = await _request(url, method, parameters);

      loadingShow(showLoading, loading, false);

      int httpCode = response.statusCode ?? HttpErrorType.UNKNOWN_ERROR;
      String httpMsg = response.statusMessage ?? "";
      dynamic httpData = response.data;

      if (_handleHttpData(httpCode, httpMsg, httpData, onComplete, onError)) {
        return;
      }

      _handleServerData(httpCode, httpMsg, httpData,
          codeLabel, messageLabel, dataLabel,
          onComplete, onSuccess, onError);
    } on DioError catch (e) {
      loadingShow(showLoading, loading, false);

      HttpDioException? exception = e.error;
      int errorCode = exception?.code ?? (e.response?.statusCode ?? HttpErrorType.UNKNOWN_ERROR);
      String message = exception?.message ?? e.message;
      if (onComplete != null) {
        onComplete(errorCode, message, null);
      }
      if (onError != null) {
        onError(errorCode, message, e.error);
      }
    }
  }

  void loadingShow(bool isShow, LoadingDialogShow? loading, bool show) {
    if (!isShow) {
      return;
    }
    if (loading != null) {
      loading(show);
    } else if (commonLoading != null) {
      commonLoading!(show);
    }
  }

  String _configUrl(String url) {
    if (url.contains("http")) {
      return url;
    } else {
      return defaultHost + url;
    }
  }

  /// 处理http的错误码
  bool _handleHttpData(int httpCode, String httpMsg, dynamic httpData,
      OnHttpCompleteCallback? onComplete, OnHttpErrorCallback? onError) {
    if (httpCode < HttpErrorType.HTTP_SUCCESS
        || httpCode > HttpErrorType.HTTP_REQUEST_REDIRECT
        || httpData == null
    ) {
      if (onComplete != null) {
        onComplete(httpCode, httpMsg, null);
      }
      if (onError != null) {
        onError(httpCode, httpMsg,
            HttpDioException(code: httpCode, message: httpMsg)
        );
      }
      return true;
    }
    return false;
  }

  void _handleServerData(int httpCode, String httpMsg, dynamic httpData,
      String? codeLabel, String? messageLabel, String? dataLabel,
      OnHttpCompleteCallback? onComplete,
      OnHttpSuccessCallback? onSuccess,
      OnHttpErrorCallback? onError) {

    int code = httpData[codeLabel ?? HttpResponseConfig.LABEL_CODE];
    String message = httpData[messageLabel ?? HttpResponseConfig.LABEL_MESSAGE];
    var data = httpData[dataLabel ?? HttpResponseConfig.LABEL_DATA];

    if (onComplete != null) {
      onComplete(code, message, data);
    }
    if (code == HttpResponseConfig.SERVER_SUCCESS && onSuccess != null) {
      onSuccess(code, message, data);
    } else if (onError != null) {
      onError(code, message, ServerException(code, message));
    } else {
      debugPrint("ServerCode:: $code => $message");
    }
    return;
  }

  void lock() {
    _mDio.lock();
  }

  void unlock() {
    _mDio.unlock();
  }

  Future<Response<dynamic>> _request(
      String url, String method,
      Map<String, dynamic>? param) async {
    if (method == HttpMethodConfig.METHOD_POST) {
      var response = await _mDio.post(
          _configUrl(url),
          data: param
      );
      return response;
    } else {
      var response = await _mDio.get(
          _configUrl(url),
          queryParameters: param
      );
      return response;
    }
  }

}

class Host {
  static String getHost() {
    if (LibConfig.baseUrl == "") {
      return LibConfig.baseTestUrl;
    } else {
      if (LibConfig.baseUrl.endsWith("/")) {
        return LibConfig.baseUrl.substring(0, LibConfig.baseUrl.length - 1);
      }
      return LibConfig.baseUrl;
    }
  }
}

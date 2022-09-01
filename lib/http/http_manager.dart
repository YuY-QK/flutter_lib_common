import 'package:dio/dio.dart';

import 'http_client.dart';
import 'http_config.dart';
import 'http_exception.dart';
import 'http_interceptors.dart';

/// 网络请求管理类
class HttpManager {

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  HttpManager._internal();

  static final HttpManager _instance = HttpManager._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory HttpManager.getInstance() => _instance;

  /// 初始化
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
    if (interceptors != null) {
      interceptors.addAll([
          ResponseParseInterceptor(),
      ]);
    }

    DioHttp.getInstance().init(
        baseUrl: baseUrl,
        codeLabel: codeLabel,
        messageLabel: messageLabel,
        dataLabel: dataLabel,
        serverSuccessCode: serverSuccessCode,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        defaultLoading: defaultLoading,
        interceptors: interceptors,
        handler: handler
    );

  }

  /// get请求
  Future<dynamic> get(String url, {
    bool? showLoading = true, LoadingDialogShow? customLoading,
    String? codeLabel, String? messageLabel, String? dataLabel,
    Map<String, dynamic>? queryParameters,
    OnHttpCompleteCallback? onComplete,
    OnHttpSuccessCallback? onSuccess,
    OnHttpErrorCallback? onError
  }) async {
    DioHttp.getInstance().request(url, HttpMethodConfig.METHOD_GET,
        showLoading:  showLoading ?? false, loading: customLoading,
        codeLabel: codeLabel, messageLabel: messageLabel, dataLabel: dataLabel,
        parameters: queryParameters,
        onComplete: onComplete, onSuccess: onSuccess, onError: onError
    );
  }

  /// post请求
  Future<dynamic> post(String url, {
    bool? showLoading = true, LoadingDialogShow? customLoading,
    String? codeLabel, String? messageLabel, String? dataLabel,
    Map<String, dynamic>? parameters,
    OnHttpCompleteCallback? onComplete,
    OnHttpSuccessCallback? onSuccess,
    OnHttpErrorCallback? onError
  }) async {
    DioHttp.getInstance().request(url, HttpMethodConfig.METHOD_POST,
        showLoading:  showLoading ?? false, loading: customLoading,
        codeLabel: codeLabel, messageLabel: messageLabel, dataLabel: dataLabel,
        parameters: parameters,
        onComplete: onComplete, onSuccess: onSuccess, onError: onError
    );
  }
}

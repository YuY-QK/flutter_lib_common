
import 'http_exception.dart';

/// 服务器返回的结构配置
class HttpResponseConfig {

  // code
  static String LABEL_CODE = "code";
  // message
  static String LABEL_MESSAGE = "msg";
  // data
  static String LABEL_DATA = "data";

  //服务器数据请求成功code码
  static int SERVER_SUCCESS = 0;

}

/// 请求方法配置
class HttpMethodConfig {
  
  /// get请求
  static const String METHOD_GET = "GET";
  
  /// post请求
  static const String METHOD_POST = "POST";
}


/// Http的代理配置
class HttpProxyConfig {

  // 是否启用代理
  static const bool PROXY_ENABLE = false;

  // 代理服务IP
  static const String PROXY_IP = "";

  // 代理服务端口
  static const String PROXY_PORT = "";

}

class HttpConfig {

  // 超时时间[毫秒]
  static const int CONNECT_TIMEOUT = 15 * 1000;
  // 响应流上前后两次接受到数据的间隔[毫秒]
  static const int RECEIVE_TIMEOUT = 15 * 1000;

}

/// 自定义加载框
typedef LoadingDialogShow = void Function(bool isOpen);

/// 响应完成回调
typedef OnHttpCompleteCallback = void Function(int code, String message, dynamic data);

/// 响应成功回调
typedef OnHttpSuccessCallback = void Function(int code, String message, dynamic data);

/// 响应失败回调
typedef OnHttpErrorCallback = void Function(int code, String message, HttpDioException error);

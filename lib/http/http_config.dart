
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

class HttpDescriptionConfig {

  // 网络异常提示
  static const String NET_ERROR = "网络异常，请检查你的网络！";

  // 请求取消
  static const String REQUEST_CANCEL = "请求取消";
  // 连接超时
  static const String TIMEOUT_CONNECT = "连接超时";
  // 请求超时
  static const String TIMEOUT_REQUEST = "请求超时";
  // 响应超时
  static const String TIMEOUT_RESPONSE = "响应超时";
  // 请求语法错误
  static const String HTTP_BAD_REQUEST = "请求语法错误";
  // 没有权限
  static const String HTTP_UNAUTHORIZED = "没有权限";
  // 服务器拒绝执行
  static const String HTTP_FORBIDDEN = "服务器拒绝执行";
  // 无法连接服务器
  static const String HTTP_NOT_FOUND = "无法连接服务器";
  // 请求方法被禁止
  static const String HTTP_PROHIBIT = "请求方法被禁止";
  // 服务器内部错误
  static const String HTTP_SERVER_ERROR = "服务器内部错误";
  // 无效的请求
  static const String HTTP_REQUEST_ERROR = "无效的请求";
  // 服务器挂了
  static const String HTTP_SERVER_DOWN = "服务器挂了";
  // 不支持HTTP协议请求
  static const String HTTP_PROTOCOL_ERROR = "不支持HTTP协议请求";
  // 未知错误
  static const String UNKNOWN_ERROR = "未知错误";

  // 请求取消原因提示
  static const String REQUEST_CANCEL_REASON = "Cancelled";



}

/// 自定义加载框
typedef LoadingDialogShow = void Function(bool isOpen);

/// 响应完成回调
typedef OnHttpCompleteCallback = void Function(int code, String message, dynamic data);

/// 响应成功回调
typedef OnHttpSuccessCallback = void Function(int code, String message, dynamic data);

/// 响应失败回调
typedef OnHttpErrorCallback = void Function(int code, String message, HttpDioException error);

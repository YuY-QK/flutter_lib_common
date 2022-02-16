
class LibConfig {

  /// 接口地址
  static String baseUrl = "";
  /// 测试接口地址
  static String baseTestUrl = "http://scu-test-api.rsdx.com";

  ///
  /// debug下请求的参数
  static Map<String, dynamic> requestParamsByDebug = Map();

  ///
  /// 倒计时单位时间 为 1000毫秒
  static int millisInCountdownUnit = 1000;

  ///
  /// 倒计时限制
  static int millisInCountdown = 72 * 60 * 60 * millisInCountdownUnit;
}

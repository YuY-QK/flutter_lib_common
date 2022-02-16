import 'package:logger/logger.dart';

class Log {
  static String _title = "Log";
  static bool _isDebug = true;

  static Logger? logger;

  static init({bool isDebug = false, String title = "Log"}) {
    _isDebug = isDebug;
    _title = title;
    logger = Logger(
      filter: MyLogFilter(_isDebug),
      printer: PrettyPrinter(
        printEmojis: false
      )
    );
  }

  static void v(dynamic obj) {
    logger?.v("$_title\n" + obj);
  }

  static void i(dynamic obj) {
    logger?.i("$_title\n" + obj.toString());
  }

  static void d(dynamic obj) {
    logger?.d("$_title\n" + obj.toString());
  }

  static void w(dynamic obj) {
    logger?.w("$_title\n" + obj.toString());
  }

  static void e(dynamic obj) {
    logger?.e("$_title\n" + obj.toString());
  }

}

class MyLogFilter extends LogFilter {
  bool _isDebug;

  MyLogFilter(this._isDebug);

  @override
  bool shouldLog(LogEvent event) {
    return _isDebug;
  }
}

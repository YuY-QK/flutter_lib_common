# flutter_lib_common

**flutter 中基础页面和网络的封装**


## 使用方法:

### 安装依赖：

安装之前请查看最新版本
新版本如有问题请使用上一版
```yaml
dependencies:
  flutter:
    sdk: flutter
  # 添加依赖
  flutter_lib_common: ^{latest version}
```


### 使用

#### 网络请求

##### 初始化：
```
void main() async {

  runApp(MyApp());

  configEnv();

}

/**
 * 配置环境
 */
Future configEnv() async {
  Log.init(isDebug: true, title: AppConfig.logTitle);

  LibConfig.baseUrl = 项目的根请求地址;
  HttpManager.getInstance().init(
      // 若LibConfig.baseUrl配置了，可不配
      baseUrl: 项目的根请求地址,
      // 服务器同学定义的请求成功码，非200
      serverSuccessCode: 0,
      // 服务器同学定义的响应码的标签名称
      codeLabel: "code",
      // 服务器同学定义的响应消息的标签名称
      messageLabel: "message",
      // 服务器同学定义的响应数据的标签名称
      dataLabel: "data",
      defaultLoading: 默认加载框,
      // 请求的超时时长，默认15000ms
      connectTimeout: 15000,
      // 响应的超时时长，默认15000ms
      receiveTimeout: 15000,
      // dio的拦截器，默认加了日志拦截器，一些公共请求头等可加在这里
      interceptors: []
  );
}
```

##### 使用示例：
```
Future<void> login(String phone) async {
    api.request(
    "/xx/xx/xx",
    {"loginKey": phone},
    showLoading: false,
    onComplete: (code, message, data) {
      Log.e("==========>Params::$data");
    });
  }
```

#### 页面基类
```
import 'package:flutter/material.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget_config.dart';

class TestFlutter extends BasePageStatefulWidget {

  @override
  State<StatefulWidget> createState() => _TestFlutterState();
}

class _TestFlutterState extends BasePageState<TestFlutter> {

  @override
  Widget buildContentBody() {
    return Container(color: Colors.white);
  }

  @override
  String getAppBarTitleText() => '标题';

  /// build 方法中必须实现buildBase
  @override
  Widget build(BuildContext context) {
    return buildBase(context);
  }

  @override
  Color getBackgroundColor() {
    return Colors.white;
  }

  @override
  Widget getEmptyLayout() {
    return Container();
  }

  @override
  TextStyle getTitleTextStyle() {
    return const TextStyle(color: Colors.black);
  }

  @override
  VoidCallback? leftIconPressed() {

  }
}

```

### 依赖库:

- 此插件中的网络请求基于[ dio](https://pub.dev/packages/dio) 的封装。

- 此插件中的日志打印基于 [logger](https://pub.flutter-io.cn/packages/logger) 的封装。

- 此插件中的页面适配基础 [flutter_screenutil](https://pub.flutter-io.cn/packages/flutter_screenutil) 的封装。

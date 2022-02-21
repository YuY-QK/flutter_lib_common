import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib_common/config/lib_config.dart';
import 'package:flutter_lib_common/http/http_manager.dart';
import 'package:flutter_lib_common/page/page_config.dart';

import 'package:flutter_lib_common/utils/log.dart';

import 'MainActivity.dart';
import 'list/list_page.dart';

void main() {
  // 状态栏透明
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
  }

  // 设置竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());

  configEnv();
}

/**
 * 配置环境
 */
Future configEnv() async {
  Log.init(isDebug: true, title: "log");

  LibConfig.baseUrl = "";
  HttpManager.getInstance().init(
      // 若LibConfig.baseUrl配置了，可不配
      baseUrl: "",
      // 服务器同学定义的请求成功码，非200
      serverSuccessCode: 0,
      // 服务器同学定义的响应码的标签名称
      codeLabel: "code",
      // 服务器同学定义的响应消息的标签名称
      messageLabel: "message",
      // 服务器同学定义的响应数据的标签名称
      dataLabel: "data",
      defaultLoading: null,
      // 请求的超时时长，默认15000ms
      connectTimeout: 15000,
      // 响应的超时时长，默认15000ms
      receiveTimeout: 15000,
      // dio的拦截器，默认加了日志拦截器，一些公共请求头等可加在这里
      interceptors: []);
}

class MyApp extends StatelessWidget {
  Widget appBuilder(BuildContext context) {
    return PageConfig.buildRefreshConfig(MaterialApp(
      home: Content(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.white,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return appBuilder(context);
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("测试")),
      body: Column(
        children: [
          TextButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MainActivity();
                }))
              },
              child: Text(
                "主页",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
          TextButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ListPage();
                }))
              },
              child: Text(
                "列表",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ],
      ),
    );
  }
}

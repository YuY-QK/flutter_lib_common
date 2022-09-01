

import 'package:dio/dio.dart';

import 'http_client.dart';

/**
    Terminal运行 flutter packages pub run build_runner build 编译生成 #.g.dart文件

    遇到错误Conflicting outputs were detected and the build is unable to prompt for permission to remove them. These outputs must be removed manually or the build can be run with `--delete-conflicting

    运行：flutter packages pub run build_runner clean
    flutter packages pub run build_runner build --delete-conflicting-outputs

 */
part 'http_request.g.dart'; //必须配置，否则无法生成.g文件

///
/// 请求类
///
// @RestApi(baseUrl: "")
abstract class ApiRequest {

  factory ApiRequest({Dio? dio, String? baseUrl}) {
    dio ??= DioHttp.getInstance().getDio();
    return _ApiRequest(dio, baseUrl: baseUrl);
  }


}
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

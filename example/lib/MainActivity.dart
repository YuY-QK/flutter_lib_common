

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget.dart';

import 'list/list_page.dart';

class MainActivity extends BasePageStatefulWidget {

  @override
  State<StatefulWidget> createState() => _MainFlutterState();
}

class _MainFlutterState extends BasePageState<MainActivity> {

  @override
  void buildConfig(BuildContext context) {
    // TODO: implement buildConfig
    super.buildConfig(context);
  }

  @override
  Widget buildContentBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  @override
  String getAppBarTitleText() => '主页面';

  @override
  Color getBackgroundColor() {
    return Colors.yellow;
  }

  @override
  TextStyle getTitleTextStyle() {
    return const TextStyle(color: Colors.black, fontSize: 20);
  }

  @override
  VoidCallback? leftIconPressed() {
    Navigator.of(context).pop();
  }

}

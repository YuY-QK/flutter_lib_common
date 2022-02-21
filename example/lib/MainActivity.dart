

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget.dart';
import 'package:flutter_lib_common/widgets/empty_layout.dart';

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
            Text("各种Widget组件展示",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),

            EmptyLayout(
              type: EmptyType.DATA_EMPTY,
              layoutArrange: EmptyArrange.ICON_TEXT,
              iconWidth: 100,
              iconBuilder: (context, tipType) =>
                tipType == EmptyType.DATA_EMPTY?
                  "assets/images/icon_empty.png":
                  "assets/images/gifindicator1.gif",
              customWidget: Padding(padding: EdgeInsets.all(8)),
            )

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

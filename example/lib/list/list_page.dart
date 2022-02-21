import 'dart:math';
import 'dart:ui';

import 'package:example/list/refresh_header_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget_config.dart';
import 'package:flutter_lib_common/page/list/base_page_list.dart';

import 'load_footer_common.dart';

class ListPage extends RefreshListPage {
  ListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListPageState();
}

class ListPageState extends RefreshListPageState<ListPage> {


  List<String> initData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  ListPageState({
    Key? key,
  }) : super(key: key,
      header: CommonHeader(),
      footer: CommonFooter());

  @override
  String getAppBarTitleText() {
    return "列表";
  }

  @override
  Color getBackgroundColor() {
    return Colors.white;
  }

  @override
  TextStyle? getTitleTextStyle() {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
  }

  @override
  VoidCallback? leftIconPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget buildContentBody(BuildContext context) {
    return buildRefreshLayout(
        context,
        ListView.builder(
          itemBuilder: (context, index) => Card(
            child: Text("条目：${data[index]}"),
          ),
          itemCount: data.length,
          itemExtent: 100.0,
        ),
        (finishCallback) async {
          await Future.delayed(Duration(milliseconds: 3000));
          int rad = Random().nextInt(10);
          data.clear();
          data.addAll(initData);
          data[rad] = "refresh : $rad";
          if (mounted) setState(() {});
          finishCallback(ListLoadStatus.Completed);
          },
        (finishCallback) async {
          await Future.delayed(Duration(milliseconds: 3000));
          for (int i = 10; i < 20; i++) {
            data.add("load $i");
          }

          if (mounted) setState(() {});

          finishCallback(ListLoadStatus.Completed);
        });
  }
}

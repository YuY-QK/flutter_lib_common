

import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_common/page/list/base_page_list_indicator.dart';
import 'package:flutter_lib_common/utils/state_notifier.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonHeader extends RefreshHeader {
  @override
  State<StatefulWidget> createState() => _CommonHeaderState();

}

class _CommonHeaderState extends RefreshHeaderState<CommonHeader> {

  final ValueNotifyData<bool> _moreStateNotify = ValueNotifyData(false);
  
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return BallPulseHeaderWidget(moreStateNotify: _moreStateNotify);
  }

  @override
  void onRefreshChange() {
    _moreStateNotify.changeData(true);
  }

  @override
  void onEndRefresh() {
    _moreStateNotify.changeData(false);
  }

  @override
  void resetValue() {
    _moreStateNotify.changeData(false);
    super.resetValue();
  }

}


/// 球脉冲组件
class BallPulseHeaderWidget extends StatefulWidget {
  final ValueNotifyData<bool> moreStateNotify;

  const BallPulseHeaderWidget({
    Key? key,
    required this.moreStateNotify
  }): super(key: key);

  @override
  BallPulseHeaderWidgetState createState() {
    return BallPulseHeaderWidgetState(moreStateNotify);
  }
}

class BallPulseHeaderWidgetState extends State<BallPulseHeaderWidget> {

  final ValueNotifyData<bool> moreStateNotify;

  BallPulseHeaderWidgetState(
      this.moreStateNotify
      ): super();

  @override
  Widget build(BuildContext context) {
    return StateNotifier<Container, bool>(
        valueNotify: moreStateNotify,
        builder: (_context, value) {
          if (!value) {
            return Container();
          }
          return Container(
              alignment: Alignment.center,
              height: 80,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset("assets/lottie/loading.json"),
                  // Text('data')
                ],
              )
          );
        });
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_common/widgets/timer/time_model.dart';
import 'package:provider/provider.dart';

import 'counter_controller.dart';

typedef CounterWidgetBuilder = Widget Function(
    BuildContext context, // 上下文
    CurrentTimeModel time  // 每次的计时
    );

/// 计数器布局
///
class CounterLayout extends StatefulWidget {

  // 毫秒单位，如果是每秒，则赋值为1000，分钟为60 * 1000，以此类推。默认为秒级[1000]
  final int millisecondUnit;
  final CounterWidgetBuilder builder;
  final TimeIncreaseController? controller;
  /// 计时停止的回调
  final VoidCallback? onStop;

  CounterLayout({
    Key? key,
    this.millisecondUnit = 1000,
    required this.builder,
    this.controller,
    this.onStop
  }): super(key: key);


  @override
  State<StatefulWidget> createState() => _CounterLayoutState();

}

class _CounterLayoutState extends State<CounterLayout> {

  late TimeIncreaseController controller;

  CounterWidgetBuilder get widgetBuilder => widget.builder;

  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() {
    controller = widget.controller ??
        TimeIncreaseController(timeIncreaseMillisecond: widget.millisecondUnit, onStop: widget.onStop);
    if (controller.isRunning == false) {
      controller.start();
    }
    /*
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    */
  }

  @override
  void didUpdateWidget(covariant CounterLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.millisecondUnit != widget.millisecondUnit ||
      widget.controller != oldWidget.controller
    ) {
      controller.dispose();
      initController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeIncreaseController>(
      create: (_) => controller,
      child: Consumer<TimeIncreaseController>(
        builder: (context, _info, _child) {
          return widgetBuilder(context, _info.currentIncreaseTime);
        },
      )
    );
  }

}
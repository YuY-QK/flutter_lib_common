import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'countdown_timer_controller.dart';
import 'time_model.dart';

typedef CountdownTimerWidgetBuilder = Widget Function(
    BuildContext context, CurrentTimeModel time);

/// 计时器
///
class CountdownTimer extends StatefulWidget {
  ///Widget displayed after the countdown
  final CountdownTimerWidgetBuilder endWidgetBuilder;

  ///Used to customize the countdown style widget
  final CountdownTimerWidgetBuilder widgetBuilder;

  ///Countdown controller, can end the countdown event early
  final CountdownTimerController? controller;

  ///Event called after the countdown ends
  final VoidCallback? onEnd;

  ///The end time of the countdown.
  final int endTime;

  CountdownTimer({
    Key? key,
    required this.endTime,
    required this.endWidgetBuilder,
    required this.widgetBuilder,
    this.controller,
    this.onEnd,
  }) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountdownTimer> {
  late CountdownTimerController controller;

  CurrentTimeModel get currentRemainingTime =>
      controller.currentRemainingTime;

  CountdownTimerWidgetBuilder get widgetBuilder =>
      widget.endTime > 0 ? widget.widgetBuilder : widget.endWidgetBuilder;

  @override
  void initState() {
    super.initState();
    initController();
  }

  ///Generate countdown controller.
  initController() {
    controller = widget.controller ??
        CountdownTimerController(endTime: widget.endTime, onEnd: widget.onEnd);
    if (controller.isRunning == false) {
      controller.start();
    }
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endTime != widget.endTime ||
        widget.controller != oldWidget.controller) {
      controller.dispose();
      initController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, currentRemainingTime);
  }

}

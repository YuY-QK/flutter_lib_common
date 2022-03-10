import 'dart:async';

import 'package:flutter/material.dart';

import 'time_model.dart';

/// 时间增长控制器.
///
class TimeIncreaseController extends ChangeNotifier {

  /// 一天的秒数
  static const int _daySecond = 60 * 60 * 24;

  /// 一小时的秒数
  static const int _hourSecond = 60 * 60;

  /// 一分钟的秒数
  static const int _minuteSecond = 60;

  /// 毫秒单位时长
  static const int milliUnit = 1000;

  /// 是否正在增长中
  bool _isRunning = false;

  /// 当前增长的时间对象
  late CurrentTimeModel _currentIncreaseTime;

  /// 计时器
  Timer? _countTimer;

  /// 计时间隔
  late Duration intervals;

  /// 增长的时间. 毫秒Millisecond
  final int timeIncreaseMillisecond;

  /// 计时停止的回调
  final VoidCallback? onStop;

  TimeIncreaseController({
    this.timeIncreaseMillisecond = 1000,
    this.onStop
  }) {
    intervals = Duration(milliseconds: timeIncreaseMillisecond);
    _currentIncreaseTime = CurrentTimeModel();
  }

  /// 是否正在进行中
  bool get isRunning => _isRunning;

  /// 当前增长的时间
  CurrentTimeModel get currentIncreaseTime => _currentIncreaseTime;

  /// 开启
  start() {
    disposeTimer();
    _isRunning = true;
    _countIncreasePeriodicEvent();
    if (_isRunning) {
      _countTimer =
          Timer.periodic(intervals, (_) => _countIncreasePeriodicEvent());
    }
  }

  /// 检测增长事件，并发出通知
  _countIncreasePeriodicEvent() {
    _currentIncreaseTime = _calculateCurrentIncreaseTime();
    notifyListeners();
    if (!_isRunning) {
      stop();
    }
  }

  stop() {
    onStop?.call();
    disposeTimer();
  }

  /// 计算当前增长时间
  CurrentTimeModel _calculateCurrentIncreaseTime() {
    int increaseTimeStamp = _currentIncreaseTime.timeStamp + timeIncreaseMillisecond;
    int increaseSecond = increaseTimeStamp ~/ milliUnit;
    int? days, hours, min;

    /// 计算天数
    if (increaseSecond >= _daySecond) {
      days = increaseSecond ~/ _daySecond;
      increaseSecond %= _daySecond;
    }

    /// 计算小时
    if (increaseSecond >= _hourSecond) {
      hours = increaseSecond ~/ _hourSecond;
      increaseSecond %= _hourSecond;
    } else if (days != null) {
      hours = 0;
    }

    /// 计算分钟
    if (increaseSecond >= _minuteSecond) {
      min = increaseSecond ~/ _minuteSecond;
      increaseSecond %= _minuteSecond;
    } else if (hours != null) {
      min = 0;
    }

    /// 计算剩余的秒/毫秒
    return CurrentTimeModel(
        days: days,
        hours: hours,
        min: min,
        sec: increaseSecond,
        milli: increaseTimeStamp % milliUnit,
        timeStamp: increaseTimeStamp
    );
  }

  disposeTimer() {
    _isRunning = false;
    _countTimer?.cancel();
    _countTimer = null;
  }

  @override
  void dispose() {
    disposeTimer();
    super.dispose();
  }
}

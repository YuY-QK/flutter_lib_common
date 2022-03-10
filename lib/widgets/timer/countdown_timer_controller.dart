import 'dart:async';

import 'package:flutter/material.dart';

import 'time_model.dart';

/// 计时器控制器
///
class CountdownTimerController extends ChangeNotifier {

  CountdownTimerController({
    required int endTime,
    this.onEnd,
    TickerProvider? vsync
  }) : this._endTimeMillisecond = endTime {
    if (vsync != null) {
      this._animationController =
          AnimationController(vsync: vsync, duration: Duration(seconds: 1));
    }
  }

  ///Event called after the countdown ends
  final VoidCallback? onEnd;

  ///The end time of the countdown. Millisecond
  int _endTimeMillisecond;

  ///Is the countdown running.
  bool _isRunning = false;

  ///Countdown remaining time.
  late CurrentTimeModel _currentRemainingTime;

  ///Countdown timer.
  Timer? _countdownTimer;

  ///Intervals.
  Duration intervals = const Duration(seconds: 1);

  ///Seconds in a day
  static const int _daySecond = 60 * 60 * 24;

  ///Seconds in an hour
  static const int _hourSecond = 60 * 60;

  ///Seconds in a minute
  static const int _minuteSecond = 60;

  /// unit by Millisecond
  static const int milliUnit = 1000;

  bool get isRunning => _isRunning;

  /// endTime：Millisecond
  set endTime(int endTime) => _endTimeMillisecond = endTime;

  ///Get the current remaining time
  CurrentTimeModel get currentRemainingTime => _currentRemainingTime;

  AnimationController? _animationController;

  ///Start countdown
  start() {
    disposeTimer();
    _isRunning = true;
    _countdownPeriodicEvent();
    if (_isRunning) {
      _countdownTimer =
          Timer.periodic(intervals, (_) => _countdownPeriodicEvent());
    }
  }

  ///Check if the countdown is over and issue a notification.
  _countdownPeriodicEvent() {
    _currentRemainingTime = _calculateCurrentRemainingTime();
    _animationController?.reverse(from: 1);
    notifyListeners();
    if (_currentRemainingTime.timeStamp == 0) {
      onEnd?.call();
      disposeTimer();
    }
  }

  ///Calculate current remaining time.
  CurrentTimeModel _calculateCurrentRemainingTime() {
    _endTimeMillisecond = _endTimeMillisecond - milliUnit;
    int remainingTimeStamp = _endTimeMillisecond ~/ milliUnit;
    if (remainingTimeStamp <= 0) {
      return CurrentTimeModel();
    }
    int? days, hours, min;

    int timeStamp = _endTimeMillisecond;

    ///Calculate the number of days remaining.
    if (remainingTimeStamp >= _daySecond) {
      days = remainingTimeStamp ~/ _daySecond;
      remainingTimeStamp %= _daySecond;
    }

    ///Calculate remaining hours.
    if (remainingTimeStamp >= _hourSecond) {
      hours = remainingTimeStamp ~/ _hourSecond;
      remainingTimeStamp %= _hourSecond;
    } else if (days != null) {
      hours = 0;
    }

    ///Calculate remaining minutes.
    if (remainingTimeStamp >= _minuteSecond) {
      min = remainingTimeStamp ~/ _minuteSecond;
      remainingTimeStamp %= _minuteSecond;
    } else if (hours != null) {
      min = 0;
    }

    ///Calculate remaining second.
    return CurrentTimeModel(
        days: days,
        hours: hours,
        min: min,
        sec: remainingTimeStamp,
        animMilliseconds: _animationController?.view,
        timeStamp: timeStamp
    );
  }

  disposeTimer() {
    _isRunning = false;
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  void dispose() {
    disposeTimer();
    _animationController?.dispose();
    super.dispose();
  }
}

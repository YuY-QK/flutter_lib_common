import 'package:flutter/animation.dart';

/// 时间模型
///
class CurrentTimeModel {
  final int? days;
  final int? hours;
  final int? min;
  final int? sec;
  final int? milli;
  final int timeStamp; //时间戳[毫秒]，时间总和，初始时为0
  final Animation<double>? animMilliseconds;

  CurrentTimeModel({
    this.days,
    this.hours,
    this.min,
    this.sec,
    this.milli,
    this.timeStamp = 0,
    this.animMilliseconds
  });

  @override
  String toString() =>
      'CurrentRemainingTime{'
          'days: $days,'
          ' hours: $hours,'
          ' min: $min,'
          ' sec: $sec,'
          ' milli: $milli,'
          ' milliseconds: ${animMilliseconds?.value}';
}
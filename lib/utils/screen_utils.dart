import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ScreenUtils {
  static const double WIDTH = 375;
  static const double HEIGHT = 667;

  // screen size, dp
  static Size getWidgetSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // screen width, dp
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // screen height, dp
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // screen size, px
  static Size getScreenSizePx() {
    return window.physicalSize;
  }

  // screen pixel ratio
  static double getScreenPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  ///
  /// 获取appbar的标题栏高度，包含状态栏
  static double getAppbarTitleHeight(BuildContext context, {bool containStatus = true}) {
    return kToolbarHeight + (containStatus ? MediaQuery.of(context).padding.top : 0);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ScreenUtils {
  static const double WIDTH = 375;
  static const double HEIGHT = 667;

  static void buildScreen(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(WIDTH, HEIGHT),
        orientation: Orientation.portrait);
  }

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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib_common/utils/screen_utils.dart';
import 'package:flutter_lib_common/widgets/text_scale_normal_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Signature of callbacks that have no arguments and return no data.
typedef VoidCallback = void Function();


abstract class BasePageStateWidgetConfig implements PageInterface {

  /// 构建base组件
  Widget buildBase(BuildContext context) {
    ScreenUtils.buildScreen(context);
    return TextScaleNormalLayout(child: buildPage(context));
  }

  ///
  /// 构建整体页面
  ///
  /// 若重写该方法，则其他方法都失效
  Widget buildPage(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //不跟随软键盘上移
        appBar: customAppBar() ?? _baseAppBar(),
        backgroundColor: getBackgroundColor(),
        body: Container(child: buildContentBody())
    );
  }

  ///
  /// base页面的AppBar
  AppBar _baseAppBar() {
    return AppBar(
      //设置title
      title: getAppBarTitle(),
      //设置title左边icon
      leading: getLeftIcon(),
      //设置title右边icon
      actions: getRightIcons(),
      //设置icon主题色
      iconTheme: getIconTheme(),
      //设置appBar 的背景颜色
      backgroundColor: getAppBarBgColor(),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),
    );
  }

  ///
  /// 自定义APPBar
  AppBar? customAppBar() {
    if (customAppBarTitle() == null) {
      return null;
    }
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: true,
      elevation: 0,
      title: customAppBarTitle(),
      backgroundColor: getAppBarBgColor(),
      leading: getLeftIcon(),
      actions: getRightIcons(),
      iconTheme: getIconTheme(),
    );
  }

  ///
  /// 自定义AppBar的标题组件
  Widget? customAppBarTitle() {
    return null;
  }

  /// AppBar的标题
  Widget getAppBarTitle() {
    return Text(
      getAppBarTitleText(),
      style: getTitleTextStyle(),
    );
  }

  /// 标题栏左侧图标
  Widget getLeftIcon() {
    return Padding(
      padding: EdgeInsets.all(5.r),
      child: IconButton(
          onPressed: leftIconPressed,
          icon: Icon(Icons.arrow_back_ios_new_outlined)),
    );
  }

  /// 标题栏右侧图标
  List<Widget>? getRightIcons() {
    return null;
  }

  /// 标题栏背景颜色
  Color getAppBarBgColor() {
    return Colors.white;
  }

  /// 标题栏图标主题
  IconThemeData getIconTheme() {
    return IconThemeData(color: Colors.black);
  }

  /// 标题栏标题文字样式
  TextStyle getTitleTextStyle();

  /// 空布局
  Widget getEmptyLayout();


  String getEmptyTip() {
    return "";
  }

  /// 背景色
  Color getBackgroundColor();

  /// 左侧按钮点击
  VoidCallback? leftIconPressed();

}

class CustomDeviceOrientation {
  void changeOrientation({required List<DeviceOrientation> orientations}) {
    SystemChrome.setPreferredOrientations(orientations);
  }
}

abstract class PageInterface {

  /// 获取AppBar的标题内容
  String getAppBarTitleText();

  /// 构建内容区域
  Widget buildContentBody();

  /// 获取页面内容
  String getPageName();
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib_common/widgets/text_scale_normal_layout.dart';

/// Signature of callbacks that have no arguments and return no data.
typedef VoidCallback = void Function();


abstract class BasePageStateWidgetConfig implements PageInterface {

  final double PADDING_LEFTICON = 5;

  /// 构建base组件
  Widget buildBase(BuildContext context) {
    buildConfig(context);
    return TextScaleNormalLayout(child: buildPage(context));
  }

  ///
  /// 构建整体页面
  ///
  /// 若重写该方法，则其他方法都失效
  Widget buildPage(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //不跟随软键盘上移
        appBar: _customAppBar() ?? _baseAppBar(),
        backgroundColor: getBackgroundColor(),
        body: Container(child: buildContentBody(context))
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
      titleTextStyle: getTitleTextStyle(),
    );
  }

  ///
  /// 自定义APPBar
  AppBar? _customAppBar() {
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
    if (!showLeftIcon()) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.all(getLeftIconPadding()),
      child: IconButton(
          onPressed: leftIconPressed,
          icon: const Icon(Icons.arrow_back_ios_new_outlined)),
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
    return const IconThemeData(color: Colors.black);
  }

  /// 标题栏标题文字样式
  TextStyle? getTitleTextStyle();

  /// 背景色
  Color getBackgroundColor();

  /// 左侧按钮点击
  VoidCallback? leftIconPressed();

  double getLeftIconPadding() {
    return PADDING_LEFTICON;
  }

  /// 是否显示左侧按钮
  bool showLeftIcon() {
    return true;
  }

  /// 构建配置，可空实现
  void buildConfig(BuildContext context) {}

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
  Widget buildContentBody(BuildContext context);

  /// 获取页面内容
  String getPageName();
}

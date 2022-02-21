
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_common/utils/string_utils.dart';

/// 空视图的图标构建
typedef EmptyTipIconBuilder = String? Function(BuildContext context, EmptyType tipType);

/// 空视图显示类型
///
enum EmptyType {

  ///
  /// 加载数据
  LOADING,

  ///
  /// 暂无数据
  DATA_EMPTY,

  ///
  /// 数据有误
  DATA_ERROR,

  ///
  /// 网络错误
  NET_ERROR,

}

///
/// 空视图排布方式
enum EmptyArrange {

  ///
  /// 上图，中间Widget，下文
  ICON_TEXT,

  ///
  /// 上文，中间Widget，下图
  TEXT_ICON,

  ///
  /// 上Widget，中图，下文
  WIDGET_ICON_TEXT,

  ///
  /// 上Widget，中文，下图
  WIDGET_TEXT_ICON,

  ///
  /// 上图，中文，下Widget
  ICON_TEXT_WIDGET,

  ///
  /// 上文，中图，下Widget
  TEXT_ICON_WIDGET,


}


class EmptyLayout extends StatelessWidget  {

  static const double DEFALUT_ICON_WIDTH = 200.0;

  final String contentText;
  final EmptyType type;
  final EmptyArrange layoutArrange;
  final TextStyle? contentTextStyle;
  final double? iconWidth; //不需要高是因为用的BoxFit.cover
  final EmptyTipIconBuilder? iconBuilder;
  final Widget? customWidget;

  const EmptyLayout({
    Key? key,
    this.type = EmptyType.DATA_EMPTY,
    this.layoutArrange = EmptyArrange.ICON_TEXT,
    this.contentText = "暂无数据",
    this.contentTextStyle,
    this.iconWidth,
    this.iconBuilder,
    this.customWidget
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    String? tipIcon;
    Image? icon;
    if (iconBuilder != null) {
      tipIcon = iconBuilder!(context, type);
    }
    if (!StringUtils.isEmpty(tipIcon)) {
      icon = Image(
          width: iconWidth ?? DEFALUT_ICON_WIDTH,
          fit: BoxFit.cover,
          image: AssetImage(tipIcon!)
      );
    }
    List<Widget> emptyChildren = buildLayout(layoutArrange, icon, customWidget);
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: emptyChildren,
      ),
    );
  }

  /// 构建布局
  List<Widget> buildLayout(EmptyArrange layoutArrange, Image? icon, Widget? customWidget) {
    List<Widget?> children = [];
    switch(layoutArrange) {
      case EmptyArrange.ICON_TEXT:
        children = [
          icon,
          customWidget,
          emptyText(),
        ];
        break;
      case EmptyArrange.TEXT_ICON:
        children = [
          emptyText(),
          customWidget,
          icon,
        ];
        break;
      case EmptyArrange.WIDGET_ICON_TEXT:
        children = [
          customWidget,
          icon,
          emptyText(),
        ];
        break;
      case EmptyArrange.WIDGET_TEXT_ICON:
        children = [
          customWidget,
          emptyText(),
          icon,
        ];
        break;
      case EmptyArrange.ICON_TEXT_WIDGET:
        children = [
          icon,
          emptyText(),
          customWidget,
        ];
        break;
      case EmptyArrange.TEXT_ICON_WIDGET:
        children = [
          emptyText(),
          icon,
          customWidget,
        ];
        break;
    }
    List<Widget> wts = <Widget>[];
    for (Widget? w in children) {
      if (w != null) {
        wts.add(w);
      }
    }
    return wts;
  }

  // 空视图文字
  Widget emptyText() {
    return Text(
      contentText,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 14,
          color: Color(0x3D000000))
          .merge(contentTextStyle),
    );
  }

}

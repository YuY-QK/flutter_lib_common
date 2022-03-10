import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnButtonClickListener = Function();
class TitleBar extends StatelessWidget {
  final String? titleText;
  final Color titleColor;
  final double? titleSize;
  final Widget? leftIcon;
  final Color? leftIconColor;
  final Color backgroundColor;
  final double paddingTop; //顶部间距，如果外层是APPbar，必须为0
  late double height;
  final OnButtonClickListener? leftClickListener;

  TitleBar(
      {Key? key,
        this.titleText,
        this.titleColor = Colors.black,
        this.titleSize,
        this.leftIcon,
        this.leftIconColor,
        this.backgroundColor = Colors.transparent,
        this.paddingTop = -1,
        this.height = 0,
        this.leftClickListener
      })
      : super(key: key ?? ValueKey(titleText));

  @override
  Widget build(BuildContext context) {
    final pTop =
        paddingTop >= 0 ? paddingTop : MediaQuery.of(context).padding.top;
    height = kToolbarHeight + pTop;
    double textFontSize = titleSize ?? 18;
    return Container(
        height: height,
        decoration: BoxDecoration(color: backgroundColor),
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(top: pTop),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(titleText ?? "",
                          style: TextStyle(color: titleColor, fontSize: textFontSize)
                      ),
                    )
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                      onPressed: leftClickListener,
                      icon: leftIcon ??
                          Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: leftIconColor ?? Colors.black,
                          )
                  ),
                )
              ],
            )
        )
    );
  }
}

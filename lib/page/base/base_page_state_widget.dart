import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib_common/utils/log.dart';

import 'base_page_state_widget_config.dart';

///
/// StatelessWidget的封装
abstract class BasePageStatelessWidget extends StatelessWidget
    with CustomDeviceOrientation, BasePageStateWidgetConfig {

  final Map? params;

  BasePageStatelessWidget({
    Key? key,
    this.params
  }) : super(key: key) {
    changeOrientation(orientations: [DeviceOrientation.portraitUp]);
  }

  @override
  String getPageName() {
    return runtimeType.toString();
  }

}


///
/// StatefulWidget的封装
abstract class BasePageStatefulWidget extends StatefulWidget
    with CustomDeviceOrientation {

  final Map? params;

  BasePageStatefulWidget({
    Key? key,
    this.params
  }) : super(key: key) {
    changeOrientation(orientations: [DeviceOrientation.portraitUp]);
  }

  String getPageName() {
    return runtimeType.toString();
  }
}

abstract class BasePageState<T extends BasePageStatefulWidget> extends State<T>
    with WidgetsBindingObserver, BasePageStateWidgetConfig {

  @override
  String getPageName() {
    return widget.getPageName();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    Log.v('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Log.v('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.v('didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    Log.v('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    Log.v('dispose');
    WidgetsBinding.instance!.removeObserver(this); //移除监听器
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Log.v('didChangeAppLifecycleState: $state');
  }

}
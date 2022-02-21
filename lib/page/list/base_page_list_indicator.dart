import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 下拉刷新头部组件
///
abstract class RefreshHeader extends RefreshIndicator {

  const RefreshHeader({
    Key? key,
    double height = 80.0,
    RefreshStyle refreshStyle = RefreshStyle.Follow
  }) : super(
      key: key,
      height: height,
      refreshStyle: refreshStyle
  );
}

abstract class RefreshHeaderState<T extends RefreshHeader> extends RefreshIndicatorState<T>
    with SingleTickerProviderStateMixin {

  @override
  void onModeChange(RefreshStatus? mode) {
    if (mode == RefreshStatus.refreshing) {
      onRefreshChange();
    }
    super.onModeChange(mode);
  }

  /// 刷新中
  void onRefreshChange();

  @override
  Future<void> endRefresh() {
    onEndRefresh();
    return super.endRefresh();
  }

  /// 刷新结束
  void onEndRefresh();

}


/// 上拉加载底部组件
abstract class LoadFooter extends LoadIndicator {

  const LoadFooter({
    Key? key
  }): super(key: key);

}

abstract class LoadFooterState<T extends LoadFooter> extends LoadIndicatorState<T> {

  @override
  Future<void> endLoading() {
    onEndLoading();
    return Future.delayed(const Duration(milliseconds: 500));
  }

  /// 加载完成
  void onEndLoading();

}
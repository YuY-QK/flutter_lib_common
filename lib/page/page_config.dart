import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 页面配置
///
class PageConfig {

  /// 构建刷新配置
  ///
  static Widget buildRefreshConfig(Widget child) {
    return RefreshConfiguration(
        // 越界回弹时拖动的速度比例,公式:原始滑动引擎拖动速度*dragSpeedRatio
        dragSpeedRatio: 0.91,
        // 默认头部指示器全局构造器
        headerBuilder: () => const MaterialClassicHeader(),
        // 默认尾部指示器全局构造器
        footerBuilder: () => const ClassicFooter(),
        // 触发下拉刷新的越界距离
        headerTriggerDistance: 80.0,
        enableRefreshVibrate: false,
        // 当ScrollView不满一页时,是否要隐藏底部指示器
        hideFooterWhenNotFull: true,
        // 距离底部边缘触发加载更多的距离,注意这个属性和header的不同,它可以为负数,负数代表越界
        footerTriggerDistance: 15.0,
        // 是否允许通过手势来触发加载更多当没有更多数据的状态
        enableLoadingWhenNoData: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: child
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_common/page/base/base_page_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef RefreshPullCallback = void Function(Function(ListLoadStatus));

enum ListLoadStatus {

  /// 完成
  Completed,

  /// 失败
  Failed,

  /// 无数据
  NoData

}

///
/// 刷新列表页面
///
abstract class RefreshListPage extends BasePageStatefulWidget {

  RefreshListPage({
    Key? key
  }) : super(key: key);

}

abstract class RefreshListPageState<T extends BasePageStatefulWidget> extends BasePageState<T> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final Widget? header;
  final Widget? footer;
  // 下拉刷新
  final bool enablePullDown;
  // 上拉加载
  final bool enablePullUp;

  RefreshListPageState({
    Key? key,
    this.header,
    this.footer,
    this.enablePullDown = true,
    this.enablePullUp = true
  });

  Widget buildRefreshLayout(BuildContext context,
      Widget? listView,
      RefreshPullCallback? onRefresh,
      RefreshPullCallback? onLoading,
      {
        Widget? header,
        Widget? footer,
        bool? enablePullDown,
        bool? enablePullUp
      }) {
    return RefreshLayout(
      controller: _refreshController,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      enablePullDown: enablePullDown ?? this.enablePullDown,
      enablePullUp: enablePullUp ?? this.enablePullUp,
      child: listView,
      onRefresh: onRefresh,
      onLoading: onLoading,
    );
  }

}

/// 刷新组件
///
class RefreshLayout extends StatefulWidget {

  final RefreshController controller;
  final Widget? child;
  final Widget? header;
  final Widget? footer;
  // 是否能下拉刷新
  final bool enablePullDown;
  // 是否能上拉加载
  final bool enablePullUp;
  final RefreshPullCallback? onRefresh;
  final RefreshPullCallback? onLoading;

  const RefreshLayout( {
    Key? key,
    required this.controller,
    this.child,
    this.header,
    this.footer,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.onRefresh,
    this.onLoading,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _RefreshLayoutState();
}

class _RefreshLayoutState extends State<RefreshLayout> {

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller,
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      header: widget.header,
      footer: widget.footer,
      onRefresh: () async {
        if (widget.onRefresh != null) {
          widget.onRefresh!((status) => {
            if (status == ListLoadStatus.Completed) {
              widget.controller.refreshCompleted()
            } else if (status == ListLoadStatus.Failed) {
              widget.controller.refreshFailed()
            } else if (status == ListLoadStatus.NoData) {
              widget.controller.refreshToIdle()
            }
          });
        }
      },
      onLoading: () async {
        if (widget.onLoading != null) {
          widget.onLoading!((status) => {
            if (status == ListLoadStatus.Completed) {
              widget.controller.loadComplete()
            } else if (status == ListLoadStatus.Failed) {
              widget.controller.loadFailed()
            } else if (status == ListLoadStatus.NoData) {
              widget.controller.loadNoData()
            }
          });
        }
      },
      child: widget.child,
    );
  }

}
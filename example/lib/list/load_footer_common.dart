
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lib_common/page/list/base_page_list_indicator.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

class CommonFooter extends LoadFooter {

  @override
  State<StatefulWidget> createState() => _CommonFooterState();

}

class _CommonFooterState extends LoadFooterState<CommonFooter> {

  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    Widget body ;
    if(mode==LoadStatus.idle){
      body =  Text("上拉加载");
    } else if(mode==LoadStatus.loading){
      body =  CupertinoActivityIndicator();
    } else if(mode == LoadStatus.failed){
      body = Text("加载失败！点击重试！");
    } else if(mode == LoadStatus.canLoading){
      body = Text("松手,加载更多!");
    } else{
      body = Text("没有更多数据了!");
    }
    return Container(
      height: 55.0,
      child: Center(child:body),
    );
  }

  @override
  void onEndLoading() {
  }

}
import 'package:flutter/material.dart';

///加载更多回调
typedef LoadMoreCallback = Future<void> Function();

///构建自定义状态返回
typedef LoadMoreBuilder = Widget Function(
    BuildContext context, LoadStatus status);

///加载状态
enum LoadStatus {
  normal, //正常状态
  error, //加载错误
  loading, //加载中
  finish, //加载完成
}

///加载更多 Widget
class LoadAny extends StatefulWidget {
  ///加载状态
  final LoadStatus status;

  ///加载更多回调
  final LoadMoreCallback onLoadMore;

  ///自定义加载更多 Widget
  final LoadMoreBuilder loadMoreBuilder;

  ///CustomScrollView
  final CustomScrollView child;

  ///到底部才触发加载更多
  final bool endLoadMore;

  ///加载更多底部触发距离
  final double bottomTriggerDistance;

  ///底部 loadmore 高度
  final double footerHeight;

  LoadAny({
    this.status,
    this.child,
    this.onLoadMore,
    this.endLoadMore = true,
    this.bottomTriggerDistance = 200,
    this.footerHeight = 40,
    this.loadMoreBuilder,
  });

  @override
  State<StatefulWidget> createState() => _LoadAnyState();
}

class _LoadAnyState extends State<LoadAny> {
  @override
  Widget build(BuildContext context) {
    ///添加 Footer Sliver
    widget.child.slivers.add(
      SliverSafeArea(
        top: false,
        left: false,
        right: false,
        sliver: SliverToBoxAdapter(
          child: _buildLoadMore(widget.status),
        ),
      ),
    );
    return NotificationListener<ScrollNotification>(
      onNotification: _handleNotification,
      child: widget.child,
    );
  }

  ///构建加载更多 Widget
  Widget _buildLoadMore(LoadStatus status) {
    ///检查返回自定义状态
    if (widget.loadMoreBuilder != null) {
      Widget loadMoreBuilder = widget.loadMoreBuilder(context, status);
      if (loadMoreBuilder != null) {
        return loadMoreBuilder;
      }
    }

    ///返回内置状态
    if (status == LoadStatus.loading) {
      return _buildLoading();
    } else if (status == LoadStatus.error) {
      return _buildLoadError();
    } else if (status == LoadStatus.finish) {
      return _buildLoadFinish();
    } else {
      return Container(height: widget.footerHeight);
    }
  }

  ///加载中状态
  Widget _buildLoading() {
    return Container(
      height: widget.footerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 20,
            height: 20,
          ),
          SizedBox(width: 10),
          Text(
            '加载中...',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ///加载错误状态
  Widget _buildLoadError() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //点击重试加载更多
        widget.onLoadMore();
      },
      child: Container(
        height: widget.footerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              '加载失败，点击重试',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///加载错误状态
  Widget _buildLoadFinish() {
    return Container(
      height: widget.footerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10,
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 6),
          Text(
            '没有更多了',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 6),
          SizedBox(
            width: 10,
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ///计算加载更多
  bool _handleNotification(ScrollNotification notification) {
    //当前滚动距离
    double currentExtent = notification.metrics.pixels;
    //最大滚动距离
    double maxExtent = notification.metrics.maxScrollExtent;
    //滚动更新过程中，并且设置非滚动到底部可以触发加载更多
    if ((notification is ScrollUpdateNotification) && !widget.endLoadMore) {
      return _checkLoadMore(
          (maxExtent - currentExtent <= widget.bottomTriggerDistance));
    }

    //滚动到底部，并且设置滚动到底部才触发加载更多
    if ((notification is ScrollEndNotification) && widget.endLoadMore) {
      //滚动到底部并且加载状态为正常时，调用加载更多
      return _checkLoadMore((currentExtent >= maxExtent));
    }

    return false;
  }

  ///处理加载更多
  bool _checkLoadMore(bool canLoad) {
    if (canLoad && widget.status == LoadStatus.normal) {
      print('ScrollEndNotification ${widget.status}');
      widget.onLoadMore();
      return true;
    }
    return false;
  }
}

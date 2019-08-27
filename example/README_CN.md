# LoadAny 示例

LoadAny 的示例程序

[English](https://github.com/yy1300326388/loadany/tree/master/example/README.md)

[![Codemagic build status](https://api.codemagic.io/apps/5d561d3a6a6c3600097b43a6/5d561d3a6a6c3600097b43a5/status_badge.svg)](https://codemagic.io/apps/5d561d3a6a6c3600097b43a6/5d561d3a6a6c3600097b43a5/latest_build)

## 入门

```Dart
import 'package:loadany/loadany.dart';
```

```Dart
LoadStatus status = LoadStatus.normal;

LoadAny(
  onLoadMore: getLoadMore,
  status: status,
  child: CustomScrollView(
    slivers: <Widget>[
      SliverGrid(...),
      SliverList(...),
    ],
  ),
)
```
```Dart
/// 加载更多数据
Future<void> getLoadMore() async {
    setState(() {
      status = LoadStatus.loading;
    });
    Timer.periodic(Duration(milliseconds: 5000), (Timer timer) {
      timer.cancel();
      int length = list.length;
      for (var i = 1; i < 11; ++i) {
        list.add(length + i);
      }
    
      if (length > 80) {
        status = LoadStatus.completed;
      } else if (length >= 50 && length < 70) {
        status = LoadStatus.error;
      } else {
        status = LoadStatus.normal;
      }
      setState(() {});
    });
}
```

### 设置加载更多底部高度

```Dart
LoadAny(
  onLoadMore: getLoadMore,
  status: status,
  footerHeight: 40, // 添加
  child: CustomScrollView(
    slivers: <Widget>[
      SliverGrid(...),
      SliverList(...),
    ],
  ),
)
```

### 设置 Feed 流式加载，并且设置距离底部多少距离触发加载

```Dart
LoadAny(
  onLoadMore: getLoadMore,
  status: status,
  endLoadMore: false, // 添加
  bottomTriggerDistance: 200, // 添加
  child: CustomScrollView(
    slivers: <Widget>[
      SliverGrid(...),
      SliverList(...),
    ],
  ),
)
```

### 自定义底部加载更多样式

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Simulator%20Screen%20Shot%2005.png" width="220"/>

```Dart
LoadAny(
  onLoadMore: getLoadMore,
  status: status,
  loadMoreBuilder: (BuildContext context, LoadStatus status) {
    if (status == LoadStatus.loading) {
      return Container(
        height: 40,
        child: Text('Loading'),
        color: Colors.green,
        alignment: Alignment.center,
      );
    }
    return null;
  },
  child: CustomScrollView(
    slivers: <Widget>[
      SliverGrid(...),
      SliverList(...),
    ],
  ),
)
```

### 添加嵌套 RefreshIndicator 下拉刷新

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2004.gif" width="220"/>

```Dart
RefreshIndicator(
    onRefresh: () async {
      if(status==LoadStatus.normal) {
        await GetData();
        ...
        setState(() {});
      }
    },
    child: LoadAny(
      onLoadMore: getLoadMore,
      status: status,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(...),
          SliverGrid(...),
          SliverList(...),
        ],
      ),
    ),
)
```




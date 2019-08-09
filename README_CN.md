# LoadAny

一个新的 Flutter 上拉加载更多库

[English](https://github.com/yy1300326388/loadany)

## 支持

* CustomScrollView
* SliverListView
* SliverGridView
* SliverListView 可替代 ListView
* SliverGridView 可替代 GridView
* 自定义各状态下的加载样式
* 可外嵌 RefreshIndicator 下拉刷新
* 支持 Feed 流式加载

## 使用

- 添加 LoadAny

```dart
import 'package:loadany/loadany.dart';
```

```dart
LoadStatus status = LoadStatus.normal;

LoadAny(
  onLoadMore: getLoadMore,
  status: status,
  footerHeight: 40,
  endLoadMore: true,
  bottomTriggerDistance: 200,
  child: CustomScrollView(
    slivers: <Widget>[
      SliverGrid(...),
      SliverList(...),
    ],
  ),
)
```

```dart
/// 加载更多 Data
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

## 截图

* 加载中

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2001.gif" width="220"/>

* 加载错误

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2002.gif" width="220"/>

* 加载完成

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2003.gif" width="220"/>

## 意见和问题

如果有任何意见和问题请提 [issues](https://github.com/yy1300326388/loadany/issues/new) 反馈给我，非常感谢
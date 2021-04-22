# LoadAny

A new Flutter loads more package.

[中文说明](https://github.com/yy1300326388/loadany/tree/master/README_CN.md)

[![Codemagic build status](https://api.codemagic.io/apps/5d561d3a6a6c3600097b43a6/5d561d3a6a6c3600097b43a5/status_badge.svg)](https://codemagic.io/apps/5d561d3a6a6c3600097b43a6/5d561d3a6a6c3600097b43a5/latest_build)

## Support

* CustomScrollView
* SliverListView
* SliverGridView
* SliverListView substitute ListView
* SliverGridView substitute GridView
* Custom loading style
* External nested RefreshIndicator
* Feed streaming

## Usage

- Add LoadAny

```Dart
import 'package:loadany/loadany.dart';
```

```Dart
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

```Dart
/// Load More Get Data
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

## Getting Started

[Getting Started](https://github.com/yy1300326388/loadany/tree/master/example)

## Screenshot

* Loading

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2001.gif" width="220"/>

* Error

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2002.gif" width="220"/>

* Completed

<img src="https://raw.githubusercontent.com/yy1300326388/loadany/develop/example/images/Kapture%2003.gif" width="220"/>

## Issues and feedback

Please file [issues](https://github.com/yy1300326388/loadany/issues/new) to send feedback or report a bug. Thank you!


### 关注我

- 遇到问题可以找我帮助解决（联系方式在 [`GitHub`](https://github.com/yy1300326388) 主页）
- 持续分享优质的 `Flutter` 文章和视频
- 不定期分享 `Flutter` 开发小技巧
- 百万级 `Flutter` 应用架构经验


<p>
  <a href="https://github.com/yy1300326388">
    <img width="200" alt="github" src="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/follow/github_follow.png">
  </a>
  <a href="https://juejin.cn/user/764915820276439">
    <img width="200" alt="juejin" src="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/follow/juejin_follow.png">
  </a>
  <a href="https://space.bilibili.com/1698847208">
    <img width="200" alt="csdn" src="https://raw.githubusercontent.com/yy1300326388/yy1300326388/main/images/follow/bilibili_follow.png">
  </a>
</p>

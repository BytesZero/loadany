# LoadAny

A new Flutter loads more package.

## Support

* CustomScrollView
* SliverListView
* SliverGridView
* SliverListView substitute ListView
* SliverGridView substitute GridView

## Usage

- Add LoadAny

```
import 'package:loadany/loadany.dart';
```

```
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

```
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
        status = LoadStatus.finish;
      } else if (length >= 50 && length < 70) {
        status = LoadStatus.error;
      } else {
        status = LoadStatus.normal;
      }
      setState(() {});
    });
}
```
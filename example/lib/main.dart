import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loadany/loadany.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter LoadMore Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///测试数据
  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  ///加载状态
  LoadStatus status = LoadStatus.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (status == LoadStatus.normal) {
            list.removeRange(10, list.length);
            setState(() {});
          }
        },
        child: LoadAny(
          onLoadMore: getLoadMore,
          status: status,
//          footerHeight: 40,
//          endLoadMore: true,
//          bottomTriggerDistance: 200,
//          loadMoreBuilder: (BuildContext context, LoadStatus status) {
//            if (status == LoadStatus.loading) {
//              return Container(
//                height: 40,
//                child: Text('Loading'),
//                color: Colors.green,
//                alignment: Alignment.center,
//              );
//            }
//            return null;
//          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Load More Demo'),
                  background: Image.network(
                    'https://cdn.pixabay.com/photo/2019/07/15/17/13/flower-4339932__480.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2019/07/21/04/28/silk-tree-4351925__480.jpg',
                        width: double.maxFinite,
                        height: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  childCount: list?.length ?? 0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildItem(index);
                  },
                  childCount: (list?.length ?? 0),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          list.clear();
          status = LoadStatus.normal;
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  ///构建 item
  Widget _buildItem(int index) {
    return Container(
      color: Colors.blue,
      margin: EdgeInsets.all(10),
      height: 80,
      child: Center(
        child: Text('${list[index]}'),
      ),
    );
  }

  ///加载更多
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
}

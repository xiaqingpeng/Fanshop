// ignore_for_file: unnecessary_this

import 'package:Fanshop/api/logs.dart';
import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_appbar.dart';

// ignore: must_be_immutable
class HistoryList extends StatefulWidget {
  String name;
  HistoryList({Key? key, required this.name}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  // 当前页数
  int _page = 1;
  // 页面数据
  final List _list = [];
  // 是否还有
  bool _hasMore = true;
  // 滚动控制器
  final ScrollController _scrollController = ScrollController();
  Map<String, int> iconPlatform = {
    "web": 0xe7e3,
    "android": 0xe87e,
    "ios": 0xe62a,
    "windows": 0xe69c,
    "macos": 0xe640,
    "linux": 0xe769,
  };
  @override
  void initState() {
    super.initState();
    _getData();
    // 监听滚动事件
    _scrollController.addListener(() {
      // 获取滚动条下拉的距离
      // print(_scrollController.position.pixels);
      // 获取整个页面的高度
      // print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 40) {
        _getData();
      }
    });
  }

  // 获取数据列表
  void _getData() async {
    if (this._hasMore) {
      List list = await GetAllLogs.getAllLogs(limit: 10, offset: _page) ?? [];
      print(list);
      setState(() {
        // 拼接数据
        _list.addAll(list);
        // 页数累加
        _page++;
      });

      if (list.length < 10) {
        setState(() {
          // 关闭加载
          _hasMore = false;
        });
      }
    }
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    print("下拉刷新");
    // 持续两秒
    await Future.delayed(const Duration(milliseconds: 1000), () {
      _getData();
    });
  }

  // 加载动画
  Widget _getMoreWidget() {
    // 如果还有数据
    if (_hasMore) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                '加载中',
                style: TextStyle(fontSize: 16.0),
              ),
              // 加载图标
              CircularProgressIndicator(
                strokeWidth: 1.0,
              )
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: Text("...我是有底线的..."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
      body: this._list.isEmpty
          ? this._getMoreWidget()
          : RefreshIndicator(
              child: ListView.builder(
                // 上拉加载控制器
                controller: _scrollController,
                itemCount: this._list.length,
                itemBuilder: (context, index) {
                  Widget tip = const Text("");
                  // 当渲染到最后一条数据时，加载动画提示
                  if (index == this._list.length - 1) {
                    tip = _getMoreWidget();
                  }
                  return Column(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(
                            IconData(iconPlatform[_list[index].platform]!,
                                fontFamily: 'iconfont2'),
                            color: Colors.black54,
                          ),
                          // title: Text(
                          //   this._list[index].handler,
                          //   maxLines: 1,
                          // ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(this._list[index].desc),

                              const SizedBox(
                                height: 6,
                              ),
                              Text(this._list[index].id),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(DateTime.parse(
                                      "${this._list[index].time.substring(0, 19)}-0800")
                                  .toString())
                            ],
                          ),
                          trailing: const Icon(
                            IconData(0xe6a3,
                                fontFamily: 'iconfont2'),
                            color: Colors.black54,
                            size: 20,
                          ),
                      ),
                      const Divider(indent: 15,endIndent: 15,),
                      // 加载提示
                      tip
                    ],
                  );
                },
              ),
              // 下拉刷新事件
              onRefresh: this._onRefresh,
            ),
    );
  }
}

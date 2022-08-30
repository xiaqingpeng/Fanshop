import 'package:Fanshop/api/order.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:Fanshop/custom/custom_card.dart';
import 'package:Fanshop/view/tabbar/mine/mineorder/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatefulWidget {
  IndexPage(
      {Key? key, required this.name, required this.id, required this.status})
      : super(key: key);
  int id;
  String name;
  String status;

  @override
  _AllGoodsState createState() => _AllGoodsState();
}

class _AllGoodsState extends State<IndexPage> {
  // 当前页数
  int _page = 1;
  // 页面数据
  final List _list = [];
  // 是否还有
  bool _hasMore = true;
  // 滚动控制器
  final ScrollController _scrollController = ScrollController();
  // status
  Map<String, String> status = {
    "Cancel": '未支付',
    "Delivered": '待支付',
    "Pending": '待收货',
    "Resolved": '待评价',
  };
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
    if (_hasMore) {
      final userInfo = await SharedPreferencesUserUtils.getUserInfo("userInfo");
      List list = await GetOrder.getOrder(
              user_id: userInfo['_id'], status: widget.status) ??
          [];
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
    } else if (_list.isEmpty) {
      return const Center(
        child: Text("暂无订单"),
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
      appBar: widget.id < 10
          ? CustomAppbar(widget.name, Theme.of(context).primaryColor)
          : null,
      body: _list.isEmpty
          ? _getMoreWidget()
          : RefreshIndicator(
              child: ListView.builder(
                // 上拉加载控制器
                controller: _scrollController,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  String  createdAt = _list[index].createdAt.toString();
                  Widget tip = const Text("");
                  // 当渲染到最后一条数据时，加载动画提示
                  if (index == _list.length - 1) {
                    tip = _getMoreWidget();
                  }
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Get.to(const OrderDetail(), arguments: _list[index]);
                        },
                        child: CustomCard(
                          height: 130,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_list[index].platform),
                                    Text(status[_list[index].status]!),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                              Icon(
                                IconData(iconPlatform[_list[index].platform]!,
                                    fontFamily:'iconfont2'),
                                color: Colors.black54,
                              ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "订单号: ${_list[index].id}",
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "下单时间: " +
                                                  DateTime.parse(
                                                          "${createdAt.substring(0, 19)}-0800")
                                                      .toString(),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "下单平台: ${_list[index].platform}",
                                              maxLines: 1,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 加载提示
                      tip
                    ],
                  );
                },
              ),
              // 下拉刷新事件
              onRefresh: _onRefresh,
            ),
    );
  }

}

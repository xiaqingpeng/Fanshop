// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_button.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/category.dart';
const double _kAppBarHeight = 256.0;
// ignore: must_be_immutable
class CategoryDetailPage extends StatefulWidget {

  Product item;
  CategoryDetailPage({Key? key, required this.item}) : super(key: key);
  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}
class _CategoryDetailPageState extends State<CategoryDetailPage>
    with TickerProviderStateMixin {
  late final List<Tab> _tabs = [
    const Tab(
      text: '详情',
    ),
    const Tab(
      text: '评论',
    ),
  ];

  late TabController _controller;

  late VoidCallback onChanged;
  late int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this);
    onChanged = () {
      setState(() {
        if (_currentIndex == 0) {
        } else {}
        _currentIndex = _controller.index;
      });
    };
    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 245),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox.fromSize(
                  size: const Size.fromHeight(_kAppBarHeight),
                  child: Image.network(
                    widget.item.product_image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TabBar(
                            tabs: _tabs,
                            indicatorWeight: 3.0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: const TextStyle(fontSize: 16.0),
                            labelColor: Colors.black,
                            controller: _controller,
                            indicatorColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                             constraints: const BoxConstraints(minHeight: 100),
                            height: _kAppBarHeight * 3,
                            
                            child: TabBarView(
                                controller: _controller,
                                children: const [
                                  Text('详情内容'),
                                  Text('评论内容'),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: -10.0,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: const BackButton(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: CustomButton(
                      backgroundColor: Colors.white,
                      borderRadius: 0.0,
                      content: Icon(
                        Icons.car_rental_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        // ignore: avoid_print
                        print("图标");
                      },
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: CustomButton(
                      backgroundColor: Colors.green,
                      borderRadius: 0.0,
                      title: "加入购物车",
                      onPressed: () {
                        // ignore: avoid_print
                        print("加入购物车");
                      },
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      backgroundColor: Colors.red,
                      borderRadius: 0.0,
                      title: "立即购买",
                      onPressed: () {
                        // ignore: avoid_print
                        print("立即购买");
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: unnecessary_const, import_of_legacy_library_into_null_safe

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/custom/custom_card.dart';
import 'package:Fanshop/viewmodel/cart/cart.dart';
import 'package:Fanshop/viewmodel/cart/check_out.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

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

  get checkOutProvider => null;
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
    CartViewmodel cartProvider = Provider.of<CartViewmodel>(context);
    CheckOutViewmodel checkOutProvider =
        Provider.of<CheckOutViewmodel>(context);
    double count = cartProvider.allCount;
    List checkoutData = [];
    checkoutData.add(
      {
        "product_id": widget.item.product_id,
        "product_name": widget.item.product_name,
        "current_price": widget.item.current_price,
        "market_price": widget.item.market_price,
        "current_count": 1,
        "checked": true,
        "product_image": widget.item.product_image,
      },
    );
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
                CustomCard(
                  padding: 2,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.item.product_name, maxLines: 2),
                        Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "￥${widget.item.current_price}元",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "比市场价低${widget.item.market_price - widget.item.current_price}元",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
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
                            constraints: BoxConstraints(
                              minHeight: _kAppBarHeight * 2,
                              minWidth: MediaQuery.of(context).size.width,
                            ),
                            height: _kAppBarHeight * 2,
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
              child: BackButton(
                color: Theme.of(context).primaryColor,
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
                      content: count > 0
                          ? Badge(
                              badgeColor: Theme.of(context).primaryColor,
                              badgeContent: Text(
                                count.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: const Icon(
                                CupertinoIcons.shopping_cart,
                              ),
                            )
                          : const Icon(
                              CupertinoIcons.shopping_cart,
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
                        context
                            .read<CartViewmodel>()
                            .setAddProduct(widget.item);
                        context.read<CartViewmodel>().computeAllCount();
                      },
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      borderRadius: 0.0,
                      title: "立即购买",
                      onPressed: () {
                        checkOutProvider.changeCheckOutListData(
                            checkoutData, context); // 提交订单
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

import 'package:flutter/material.dart';
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/custom/custom_card.dart';
import 'package:Fanshop/view/tabbar/category/category_detail.dart';
import 'package:Fanshop/viewmodel/cart/check_out.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
import 'package:provider/src/provider.dart';
import 'package:provider/provider.dart';
class RecommendPage extends StatefulWidget {
  List<Product> products;
  RecommendPage({Key? key, required this.products})
      : super(key: key);
  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.products);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (content, index) {
          return itemBuilder(context, index, widget.products);
        },
        childCount: widget.products.length,
      ),
    );


  }

  Widget itemBuilder(BuildContext context, int index, products) {
    Product item = products[index];
    CheckOutViewmodel checkOutProvider =
    Provider.of<CheckOutViewmodel>(context);
    return CustomCard(
      height: ScreenAdapter.value(400),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CategoryDetailPage(item: item);
            },
          ),
        );
      },
      child: Column(
        children: <Widget>[
          SizedBox(
            // width: ScreenAdapter.value(160),
            height: ScreenAdapter.value(200),
            child: Image.network(
              products[index].product_image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(ScreenAdapter.value(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(products[index].product_name, maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥${products[index].current_price.toString()}元",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            // fontSize: ScreenAdapter.value(40.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          title: '立即购买',
                          fontSize: ScreenAdapter.value(30),
                          height: ScreenAdapter.value(70),
                          width: ScreenAdapter.value(200),
                          onPressed: () {
                            List checkoutData = [];
                            checkoutData.add({
                              "product_id": item.product_id,
                              "product_name": item.product_name,
                              "current_price": item.current_price,
                              "market_price": item.market_price,
                              "current_count": 1,
                              "checked": true,
                              "product_image": item.product_image,
                            });
                            checkOutProvider.changeCheckOutListData(
                                checkoutData, context); // 提交订单
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


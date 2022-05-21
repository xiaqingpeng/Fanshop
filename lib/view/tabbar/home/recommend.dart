// ignore_for_file: unused_import

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/custom/custom_card.dart';
import 'package:Fanshop/view/tabbar/category/category_detail.dart';
import 'package:Fanshop/viewmodel/cart/check_out.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
import 'package:Fanshop/viewmodel/home/home.dart';
// ignore: implementation_imports, import_of_legacy_library_into_null_safe
import 'package:provider/src/provider.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  // ignore: prefer_typing_uninitialized_variables
  @override
  initState() {
    super.initState();
    context.read<CategoryViewmodel>().getProduct(0);
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.watch<CategoryViewmodel>().products;
    return SliverList(
      delegate: SliverChildBuilderDelegate((content, index) {
        return itemBuilder(context, index);
      }, childCount: products.length),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    List<Product> products = context.watch<CategoryViewmodel>().products;
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
                              fontSize: ScreenAdapter.value(40.0)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          backgroundColor: Colors.grey[300],
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

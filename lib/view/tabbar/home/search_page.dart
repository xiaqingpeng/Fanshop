import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/api/product.dart';
import 'package:Fanshop/custom/custom_search.dart';
import 'package:Fanshop/view/tabbar/home/recommend.dart';

import 'package:Fanshop/viewmodel/category/category.dart';
// import 'package:Fanshop/view/tabbar/home/products.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/custom/custom_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> products = [];
  List history = [];
  List recommend = [];
  @override
  void initState() {
    getList();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/search",'搜索');
    super.initState();
  }

  getList() async {
    var data = await RecordProduct.recordProduct();
    setState(
      () {
        history = data['history'];
        recommend = data['recommend'];
      },
    );
  }

  void  searchProduct(String text) async {
    if (text.isEmpty) {
      return setState(
            () {
          products = [];
        },
      );
    }
    var _products = await SearchProduct.searchProduct(text);
    if (_products.length > 0) {

      await AddHistorys.addHistorys(text);

    }
    setState(
          () {
        products = _products;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        'home'.tr,
        Colors.white,
        content: CustomSearch(
          onClick: (text)  {
            searchProduct(text);
          },
          onChanged: (text) {
            BrnToast.show('正在输入 : $text', context);
          },
          onSubmitted: (text) {
            BrnToast.show('完成输入 : $text', context);
          },
          onCancel: () {
            BrnToast.show('取消输入', context);
            setState(
              () {
                products = [];
              },
            );
          },
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: products.isEmpty
          ? UnSearch(history, recommend)
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                const CupertinoSliverRefreshControl(),
                RecommendPage(
                  products: products,
                ),
              ],
            ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UnSearch(history,recommend) {
    print(history);
    print(recommend);
    return Column(
      children: [
        ListTile(
          title: const Text('搜索历史'),
          trailing: GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () {
               
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BrnTextButtonPanel(
            nameList: [...history.map((e)=>e['data'].toString()).toList()] ,

            onTap: (index) {
              BrnToast.show('第$index个操作', context);
              searchProduct(history[index]);
            },
          ),
        ),
        ListTile(
          title: const Text('搜索发现'),
          trailing: GestureDetector(
            child: const Icon(Icons.visibility),
            onTap: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BrnTextButtonPanel(
            nameList: [...recommend.map((e)=>e['product_name'].toString()).toList()] ,
            onTap: (index) {
              BrnToast.show('第$index个操作', context);
              searchProduct(recommend[index]['product_name']);
            },
          ),
        ),
      ],
    );
  }


}

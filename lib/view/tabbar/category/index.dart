import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
import 'category_detail.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/category.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/product.dart';
// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, required this.name}) : super(key: key);
  String name;
  @override
  _CategoryPage createState() => _CategoryPage();
}
class _CategoryPage extends State<CategoryPage> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
      body: VerticalTabs(
        tabsWidth: 100,
        selectedTabBackgroundColor: Theme.of(context).primaryColor,
        onSelect: null,
        tabs: categorys
              .map(
                (item) => Tab(
                  child: Container(
                    height: 48.0,
                    alignment: Alignment.center,
                    child: Text(item.category_name),
                  ),
                ),
              )
              .toList(),
        contents:categorys.map((item) => Content(products)).toList()
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Content (List<Product> products){
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 0.0),
      child: GridView.count(
        // physics: const NeverScrollableScrollPhysics(), // 禁止滚动
        crossAxisCount: 2,
        children: products.map(
          (item) {
            return InkWell(
              onTap: () =>_onTap(item),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    item.product_image,
                    width: 80.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    item.product_name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // 溢出影藏
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
  void _onTap(Product item) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CategoryDetailPage(item: item);
        },
      ),
    );
  }
}


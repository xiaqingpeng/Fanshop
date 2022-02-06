import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_empty.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
import 'category_detail.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/category.dart';

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
    context.read<CategoryViewmodel>().getCategory();
    super.initState();
  }

  _onSelect(int index, categorys) {
    final int id = categorys[index].category_id;
    context.read<CategoryViewmodel>().getProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categorys = context.read<CategoryViewmodel>().getCategorys;
    List<Product> products =
        Provider.of<CategoryViewmodel>(context).getProducts;
    return Scaffold(
      appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
      body: categorys.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : VerticalTabs(
              tabsWidth: 100,
              selectedTabBackgroundColor: Theme.of(context).primaryColor,
              onSelect: (int index) => _onSelect(index, categorys),
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
              contents: categorys.map(
                (Category item) {
                  return products.isEmpty
                      ? const CustomEmpty()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 0.0),
                          child: GridView.count(
                            // physics: const NeverScrollableScrollPhysics(), // 禁止滚动
                            crossAxisCount: 2,
                            children: products.map(
                              (Product item) {
                                return InkWell(
                                  onTap: () {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        item.product_image,
                                        width: 80.0,
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
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
                },
              ).toList(),
            ),
    );
  }
}

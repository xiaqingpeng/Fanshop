import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/view/tabbar/category/category_content.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
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
      appBar: CustomAppbar('category'.tr, Theme.of(context).primaryColor),
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
                  return CategoryContent(title: null,
                   
                  );
                },
              ).toList(),
            ),
    );
  }
}

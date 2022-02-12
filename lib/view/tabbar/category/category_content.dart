import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_empty.dart';
import 'package:kuangxianjiaoapp/custom/custom_navigationbar.dart';
import 'package:kuangxianjiaoapp/view/tabbar/category/category_detail.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/category.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryContent extends StatefulWidget {
  String? title;
  CategoryContent({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    List<Product> products =
        Provider.of<CategoryViewmodel>(context).getProducts;
    if (widget.title == null) {
      return products.isEmpty ? const CustomEmpty() : Content();
    }
    return products.isEmpty
        ? Scaffold(
            appBar: CustomNavigatorBar(
              title: widget.title,
              bgColor: Theme.of(context).primaryColor,
            ),
            body: const CustomEmpty(),
          )
        : Scaffold(
            appBar: CustomNavigatorBar(
              title: widget.title,
              bgColor: Theme.of(context).primaryColor,
            ),
            body: Content(),
          );
  }

  // ignore: non_constant_identifier_names
  Widget Content() {
    List<Product> products =
        Provider.of<CategoryViewmodel>(context).getProducts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
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
  }
}

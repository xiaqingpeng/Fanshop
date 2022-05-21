import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:Fanshop/view/tabbar/category/category_content.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
import 'package:Fanshop/viewmodel/home/home.dart';
// ignore: implementation_imports, import_of_legacy_library_into_null_safe
import 'package:provider/src/provider.dart';

class TopNavigation extends StatefulWidget {
  const TopNavigation({Key? key}) : super(key: key);

  @override
  State<TopNavigation> createState() => _TopNavigationState();
}

class _TopNavigationState extends State<TopNavigation> {
  @override
  initState() {
    super.initState();
    context.read<CategoryViewmodel>().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categorys = context.watch<CategoryViewmodel>().categorys;
    return SliverGrid.count(
      crossAxisCount: 5,
      children: categorys.map((e) {
        return InkWell(
          onTap: () {
            final int id = e.category_id;
            print(id);
            context.read<CategoryViewmodel>().getProduct(id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoryContent(title: '分类');
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: ScreenAdapter.value(5)),
                width: ScreenAdapter.value(100),
                height: ScreenAdapter.value(100),
                child: Image.network(
                  e.category_img,
                  fit: BoxFit.cover,
                  width: ScreenAdapter.value(50),
                  height: ScreenAdapter.value(50),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).primaryColor, //边框颜色
                    style: BorderStyle.solid,
                    width: ScreenAdapter.value(1.0), // 边框宽度
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(ScreenAdapter.value(30)),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenAdapter.value(5.0)),
                child: Text(
                  e.category_name,
                  style: TextStyle(
                    fontSize: ScreenAdapter.value(20.0),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

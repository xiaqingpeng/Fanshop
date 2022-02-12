import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:kuangxianjiaoapp/custom/custom_navigationbar.dart';
import 'package:kuangxianjiaoapp/view/tabbar/category/category_content.dart';
import 'package:kuangxianjiaoapp/viewmodel/category/category.dart';
import 'package:kuangxianjiaoapp/viewmodel/home/home.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categorys = context.read<HomeViewmodel>().getCategorys;
    return Padding(
      padding: EdgeInsets.all(ScreenAdapter.value(20)),
      child: Wrap(
        spacing: ScreenAdapter.value(20.0),
        runSpacing: ScreenAdapter.value(20.0),
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
                  width: ScreenAdapter.value(120),
                  height: ScreenAdapter.value(120),
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
                Text(e.category_name)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

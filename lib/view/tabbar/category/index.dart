import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/custom/custom_appbar_actions.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:Fanshop/view/tabbar/category/category_content.dart';
import 'package:Fanshop/view/tabbar/category/webview_html.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:barcode_scan2/barcode_scan2.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, required this.name}) : super(key: key);
  String name;
  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  var textStr = '';
  @override
  initState() {
    super.initState();
    context.read<CategoryViewmodel>().getCategory();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/category", {});
  }

  _onSelect(int index, categorys) {
    final int id = categorys[index].category_id;
    context.read<CategoryViewmodel>().getProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categorys = context.watch<CategoryViewmodel>().categorys;
    print(categorys.toString() + 'categorys');
    return Scaffold(
      appBar: CustomAppbarActions(
        'category'.tr,
        Theme.of(context).primaryColor,
        [
          PlatformUtils.isWeb
              ? Row()
              : IconButton(
                  onPressed: () {
                    getQrcodeState().then(
                      (value) => setState(
                        () {
                          // print(value.toString()+'testoop');
                          textStr = value!;
                          if (value.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return WebViewHtml(
                                    title: value,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    IconData(0xe8b5, fontFamily: 'iconfont2'),
                  ),
                ),
        ],
      ),
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
                  return CategoryContent(
                    title: null,
                  );
                },
              ).toList(),
            ),
    );
  }

  //扫描二维码
  static Future<String?> getQrcodeState() async {
    try {
      const ScanOptions options = ScanOptions(
        strings: {
          'cancel': '取消',
          'flash_on': '开启闪光灯',
          'flash_off': '关闭闪光灯',
        },
      );
      final ScanResult result = await BarcodeScanner.scan(options: options);
      return result.rawContent;
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}

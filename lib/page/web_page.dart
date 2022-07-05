import 'package:flutter/material.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/customize_appbar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewPage extends StatefulWidget {
  String url;

  WebViewPage({required this.url});
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Scaffold(
      appBar: MyAppBar(
        key: GlobalKey(),
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child:
            CommonBackTopBar(title: "网页", onBack: () => Navigator.pop(context)),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            onWebViewCreated: (WebViewController web) {
              web.canGoBack().then((res) {
//                print(res); // 是否能返回上一级
              });
              web.currentUrl().then((url) {
//                print(url); // 返回当前url
              });
              web.canGoForward().then((res) {
//                print(res); //是否能前进
              });
            },
            onPageFinished: (String value) {
              // 返回当前url
//              print(value);
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _loading()
        ],
      ),
    );
  }

  _loading() {
    return _isLoading == true
        ? Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Text('');
  }
}

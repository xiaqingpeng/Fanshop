import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_navigationbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewHtml extends StatefulWidget {
  String title;
  WebViewHtml({Key? key, required this.title}) : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewHtml> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.title,
          ),
           Positioned(
            top: 10.0,
            left: -10.0,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: BackButton(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

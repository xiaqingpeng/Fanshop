// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// class AboutMallPage extends StatelessWidget {
//   int id;
//   String name;
//   AboutMallPage({Key key, this.name,this.id}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//          title: Text('$name'),
//       ),
//       body: WebView(
//         initialUrl: "https://www.taobao.com/",
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:convert';

// class MineAddressPage extends StatelessWidget {
//   int id;
//   String name;
//   MineAddressPage({Key key, this.name,this.id}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$name'),
//       ),
//       body: Center(
//         child: Text('$name'),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AboutMallPage extends StatefulWidget {
  int id;
  String name;
  AboutMallPage({required Key key, required this.name, required this.id})
      : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AboutMallPage> {
  String debugLable = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override

// 编写视图
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('极光推送'),
        ),
        body: Center(
            child: Column(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: const Text("发本地推送"), onPressed: () {}),
              ]),
        ])),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class JiGuangWebView extends StatefulWidget {
  const JiGuangWebView({Key? key}) : super(key: key);

  @override
  _JiGuangWebViewState createState() => _JiGuangWebViewState();
}

class _JiGuangWebViewState extends State<JiGuangWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('web 平台'),
      ),
      body: const Center(
        child: Text('web 平台'),
      ),
    );
  }
}

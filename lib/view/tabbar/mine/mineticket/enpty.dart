// ignore_for_file: deprecated_member_use

import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/view/main_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnptyPage extends StatelessWidget {
  const EnptyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.payment,
            size: 50.0,
            color: Colors.grey,
          ),
          Container(
            child: const Text('你还没有相关的订单'),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          ),
          Container(
            child: const Text('可以看看有哪些新买的'),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          ),
          CustomButton(
            content: const Text(
              '随便逛逛',
              style: TextStyle(color: Colors.white),
            ),
            borderRadius: 4.0,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const MainView()),
              // ignore: unnecessary_null_comparison
              (route) => route == null,
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 40,
          )
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/view/main_view.dart';

class EmptyItem extends StatefulWidget {
  const EmptyItem({Key? key}) : super(key: key);

  @override
  State<EmptyItem> createState() => _EmptyItemState();
}

class _EmptyItemState extends State<EmptyItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              IconData(0xe7b2, fontFamily: 'iconfont2'),
              size: 50.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text('购物车还是空的,快去挑选商品'),
          const SizedBox(
            height: 20.0,
          ),
          CustomButton(
            content: const Text(
              '随便逛逛',
              style: TextStyle(color: Colors.white),
            ),
            borderRadius: 4.0,
            onPressed: () => goHomePage(),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 40,
          )
        ],
      ),
    );
  }

  void goHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => const MainView()),
      // ignore: unnecessary_null_comparison
      (route) => route == null,
    );
  }
}

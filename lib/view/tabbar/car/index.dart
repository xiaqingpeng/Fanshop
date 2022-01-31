import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/view/main_view.dart';
// ignore: must_be_immutable
class CarPage extends StatefulWidget {
  String name;
  CarPage({Key? key, required this.name}) : super(key: key);

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.shopping_cart,
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

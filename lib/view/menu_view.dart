import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        '菜单',
        Theme.of(context).primaryColor,
        [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('theme');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

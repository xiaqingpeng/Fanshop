// ignore_for_file: unnecessary_this

import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';

// ignore: must_be_immutable
class MineAddressPage extends StatefulWidget {
  int id;
  String name;
  // ignore: use_key_in_widget_constructors
  MineAddressPage({required this.name, required this.id});
  @override
  // ignore: no_logic_in_create_state
  _MyAppState createState() => _MyAppState(id: this.id, name: this.name);
}

class _MyAppState extends State<MineAddressPage> with TickerProviderStateMixin {
  int id;
  String name;

  _MyAppState({required this.name, required this.id});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name,
        Theme.of(context).primaryColor,
      ),
      body: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Text('广东省深圳市南山区科技园')
                    ],
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                );
              },
              itemCount: 100,
            ),
            Positioned(
              bottom: 0.0,
              left: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: 4.0,
                    content: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                        Text(
                          '新增收货地址',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//  Stack(
//         children: <Widget>[
//           SingleChildScrollView(
//             child: Column(
//               children:  <Widget>[
//                SizedBox.fromSize(
//                   size: Size.fromHeight(MediaQuery.of(context).size.height),

//                 ),
//               ],
//             ),
//           ),

//           Positioned(
//             bottom: 0.0,
//             left: 0,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomButton(
//                   backgroundColor: Theme.of(context).primaryColor,
//                   borderRadius: 0.0,
//                   content: Row(
//                     children: const [
//                       Icon(
//                         CupertinoIcons.add,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         '新增收货地址',
//                         style: TextStyle(color: Colors.white),
//                       )
//                     ],
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar_actions.dart';
import 'package:kuangxianjiaoapp/view/tabbar/message/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe

// ignore: must_be_immutable
class MessagePage extends StatefulWidget {
  String name;
  MessagePage({Key? key, required this.name}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        'message'.tr,
        Theme.of(context).primaryColor,
        [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.name),
          ],
        ),
      ),
    );
  }

  _onPressed() {}
}

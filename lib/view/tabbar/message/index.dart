import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/custom/custom_appbar_actions.dart';
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
  void initState() {
    super.initState();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/category");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        'message'.tr,
        Theme.of(context).primaryColor,
        [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('message'.tr),
          ],
        ),
      ),
    );
  }
}

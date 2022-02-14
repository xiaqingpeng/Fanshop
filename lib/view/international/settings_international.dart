// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/getx/messages_getx.dart';
import 'package:kuangxianjiaoapp/global/global_international.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';

// ignore: must_be_immutable
class SettingsInternational extends StatefulWidget {
  const SettingsInternational({Key? key}) : super(key: key);
  @override
  _SettingsInternationalState createState() => _SettingsInternationalState();
}

class _SettingsInternationalState extends State<SettingsInternational> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('language'.tr, Theme.of(context).primaryColor),
      body: ListView.builder(
        itemBuilder: itemBuilder,
        itemCount: international.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final MessagesController messagesController =
        Get.put(MessagesController()); //获取state的值
    final LanguageController languageController =
        Get.put(LanguageController()); //获取state的值
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (LanguageController c) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () async {
              languageController.language(index); // 修改state的值
              messagesController.changeLanguage(international[index]['lanuage'],
                  international[index]['mark']);
            },
            child: Container(
              width: double.infinity,
              height: 50.0,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    international[index]['text'],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Visibility(
                    visible: c.count == index,
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
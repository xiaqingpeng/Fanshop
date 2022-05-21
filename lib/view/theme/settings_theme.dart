import 'package:Fanshop/api/user.dart';
import 'package:Fanshop/getx/messages_getx.dart';
import 'package:Fanshop/viewmodel/theme/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:Fanshop/global/global_theme.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({Key? key}) : super(key: key);

  @override
  State<SettingsTheme> createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  late Map<dynamic, dynamic> userInfo = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('theme'.tr, Theme.of(context).primaryColor),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<UserInfoController>(
            init: UserInfoController(),
            builder: (UserInfoController c) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    final UserInfoController userInfoController = Get.put(
                      UserInfoController(),
                    ); //获取state的值
                    final Map params = {...c.userInfo, "theme": index};
                    userInfoController.changeUserInfo(params);
                    context.read<ThemeViewmodel>().setColor(index);
                    UpdateUserInfo.updateUserInfo(params, params['_id']);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: themes[index],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // ignore: unrelated_type_equality_checks
                    child: c.userInfo['theme'] == index
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                WeIcons.hook,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 16,
                              )
                            ],
                          )
                        : Row(),
                  ),
                ),
              );
            },
          );
        },
        itemCount: themes.length,
        shrinkWrap: true,
      ),
    );
  }
}

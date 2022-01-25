import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/global/global_theme.dart';
import 'package:kuangxianjiaoapp/viewmodel/theme_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({Key? key}) : super(key: key);

  @override
  State<SettingsTheme> createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  @override
  Widget build(BuildContext context) {
    final int color = Provider.of<ThemeViewmodel>(context).getColor;
    return Scaffold(
      appBar: CustomAppbar('设置主题', Theme.of(context).primaryColor),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setInt('color', index);
                context.read<ThemeViewmodel>().setColor(index);
                // Provider.of<ThemeViewmodel>(context, listen: false)
                //     .setColor(index);
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
                child: color == index
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
        itemCount: themes.length,
        shrinkWrap: true,
      ),
    );
  }
}

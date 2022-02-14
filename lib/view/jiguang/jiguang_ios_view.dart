import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class JiGuangIosView extends StatefulWidget {
  const JiGuangIosView({Key? key}) : super(key: key);
  @override
  _JiGuangIosViewState createState() => _JiGuangIosViewState();
}

class _JiGuangIosViewState extends State<JiGuangIosView> {
  final JPush jpush = JPush();
  String alert = 'Unknown'; /*内容*/
  String title = 'Unknown'; /*标题*/
  Future<void> initPlatformState() async {
    const bool inProduction = bool.fromEnvironment('dart.vm.product');
    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          // ignore: avoid_print
          print('onReceiveNotification $message');
          setState(() {
            alert = message['alert'];
            title = message['title'];
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          // ignore: avoid_print
          print('onOpenNotification $message');
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          // ignore: avoid_print
          print('onReceiveMessage $message');
        },
        onReceiveNotificationAuthorization:
            (Map<String, dynamic> message) async {
          // ignore: avoid_print
          print('onReceiveNotificationAuthorization $message');
        },
      );
      // ignore: empty_catches, nullable_type_in_catch_clause
    } on PlatformException {}
    jpush.setup(
        appKey: "795d12ec356deba0d14130d9",
        channel: "developer-default",
        production: inProduction,
        debug: inProduction //debug 日志 true=打印
        );

    jpush.applyPushAuthority(const NotificationSettingsIOS(
      sound: true,
      alert: true,
      badge: true,
    ));
    jpush.getRegistrationID().then(
          (String rid) => {
            // ignore: avoid_print
            print('getRegistrationID $rid')
          },
        );
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('极光推送'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('标题: $title\n'),
            Text('内容: $alert\n'),
            ElevatedButton(
              child: const Text(
                '极光消息推送',
              ),
              onPressed: () {
                /*三秒后出发本地推送*/
                var fireDate = DateTime.fromMillisecondsSinceEpoch(
                    DateTime.now().millisecondsSinceEpoch + 3000);
                var localNotification = LocalNotification(
                  id: 123,
                  title: '问候邝邝',
                  buildId: 1,
                  content: '邝邝小朋友你好呀',
                  fireTime: fireDate,
                  subtitle: '我是推送测试副标题',
                );
                jpush.sendLocalNotification(localNotification); // 推送消息
              },
            ),
          ],
        ),
      ),
    );
  }
}

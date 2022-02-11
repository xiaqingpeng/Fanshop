import "package:get/get.dart";

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'language': '设置语言',
          'theme': '设置主题',
          'cache': '清除缓存',
          'logout': '退出登录',
          'home': '首页',
          'category': '分类',
          'cart': '购物车',
          'mine': '我的',
        },
        'en_US': {
          'language': 'Set Language',
          'theme': 'Set Theme',
          'cache': 'Clear Cache',
          'logout': 'Log Out',
          'home': 'Home',
          'category': 'Category',
          'cart': 'Car',
          'mine': 'Mine',
        },
      };
}

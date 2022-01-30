// 昵称格式：限16个字符，支持中英文、数字、减号或下划线
bool isNickname(String input) {
  RegExp nickname = RegExp(r'^[\\u4e00-\\u9fa5_a-zA-Z0-9-]{1,16}$');
  return nickname.hasMatch(input);
}

// 电话号码校验
bool isAllPhone(String input) {
  RegExp mobile = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  return mobile.hasMatch(input);
}

// 电话号码：1开头，后面10位数字
bool isPhone(String input) {
  RegExp mobile = RegExp(r"1[0-9]\d{9}$");
  return mobile.hasMatch(input);
}

// 登录密码：6~16位数字和字符组合
bool isLoginPassword(String input) {
  RegExp password = RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
  return password.hasMatch(input);
}

// 登录密码：6位数字验证码
bool isValidateCaptcha(String input) {
  if(input.length!=6)return false;
  RegExp captcha = RegExp(r"\d{6}$");
  return captcha.hasMatch(input);
}

// 带校验的中文姓名
bool isFullname(String input) {
  RegExp fullname = RegExp(r"^[\u4e00-\u9fa5]+(·[\u4e00-\u9fa5]+)*$");
  return fullname.hasMatch(input);
}

// 带校验的身份证
bool isCardId(String cardId) {
  if (cardId.length != 18) {
    return false; // 位数不够
  }
  // 身份证号码正则
  RegExp postalCode = RegExp(
      r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
  // 通过验证，说明格式正确，但仍需计算准确性
  if (!postalCode.hasMatch(cardId)) {
    return false;
  }
  //将前17位加权因子保存在数组里
  final List idCardList = [
    "7",
    "9",
    "10",
    "5",
    "8",
    "4",
    "2",
    "1",
    "6",
    "3",
    "7",
    "9",
    "10",
    "5",
    "8",
    "4",
    "2"
  ];
  //这是除以11后，可能产生的11位余数、验证码，也保存成数组
  final List idCardYArray = [
    '1',
    '0',
    '10',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2'
  ];
  // 前17位各自乖以加权因子后的总和
  int idCardWiSum = 0;

  for (int i = 0; i < 17; i++) {
    int subStrIndex = int.parse(cardId.substring(i, i + 1));
    int idCardWiIndex = int.parse(idCardList[i]);
    idCardWiSum += subStrIndex * idCardWiIndex;
  }
  // 计算出校验码所在数组的位置
  int idCardMod = idCardWiSum % 11;
  // 得到最后一位号码
  String idCardLast = cardId.substring(17, 18);
  //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
  if (idCardMod == 2) {
    if (idCardLast != 'x' && idCardLast != 'X') {
      return false;
    }
  } else {
    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    if (idCardLast != idCardYArray[idCardMod]) {
      return false;
    }
  }
  return true;
}

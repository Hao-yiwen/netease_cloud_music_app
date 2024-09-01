import 'package:intl/intl.dart';

/// 计算出生年份
int calculateBirthYear(String birthday) {
  DateTime currentDate = DateTime.now();
  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(birthday));
  int birthYear = date.year;

  // 如果今年的生日还没过，则出生年份减去1
  if (currentDate.month < date.month ||
      (currentDate.month == date.month && currentDate.day < date.day)) {
    birthYear--;
  }

  return birthYear;
}

// 计算年龄
String getGenerationLabel(int yearOfBirth) {
  if (yearOfBirth >= 2000) {
    return "00后";
  } else if (yearOfBirth >= 1995) {
    return "95后";
  } else if (yearOfBirth >= 1990) {
    return "90后";
  } else if (yearOfBirth >= 1985) {
    return "85后";
  } else if (yearOfBirth >= 1980) {
    return "80后";
  } else if (yearOfBirth >= 1970) {
    return "70后";
  } else if (yearOfBirth >= 1960) {
    return "60后";
  } else {
    return "60前";
  }
}

/// 计算星座
String calculateZodiacSign(String birthday) {
  // 将毫秒数转换为 DateTime 对象
  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(birthday));

  int month = date.month;
  int day = date.day;

  if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
    return "水瓶座";
  } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
    return "双鱼座";
  } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
    return "白羊座";
  } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
    return "金牛座";
  } else if ((month == 5 && day >= 21) || (month == 6 && day <= 21)) {
    return "双子座";
  } else if ((month == 6 && day >= 22) || (month == 7 && day <= 22)) {
    return "巨蟹座";
  } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
    return "狮子座";
  } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
    return "处女座";
  } else if ((month == 9 && day >= 23) || (month == 10 && day <= 23)) {
    return "天秤座";
  } else if ((month == 10 && day >= 24) || (month == 11 && day <= 22)) {
    return "天蝎座";
  } else if ((month == 11 && day >= 23) || (month == 12 && day <= 21)) {
    return "射手座";
  } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
    return "摩羯座";
  } else {
    return "未知星座";
  }
}

enum GENDER_STATUS {
  FEAMLE(0),
  MEAL(1);

  final int value;

  const GENDER_STATUS(this.value);
}

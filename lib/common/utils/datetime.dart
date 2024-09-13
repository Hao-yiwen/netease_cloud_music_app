import 'package:intl/intl.dart';

String FormatTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // 使用 DateFormat 格式化日期为 "年-月-日"
  String formattedDate = DateFormat('yyyy年MM月dd日').format(date);
  return formattedDate;
}

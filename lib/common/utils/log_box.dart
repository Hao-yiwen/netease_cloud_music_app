import 'package:logger/logger.dart';

class LogBox {
  static var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      // 显示堆栈追踪行数
      errorMethodCount: 8,
      // 错误时显示的堆栈追踪行数
      lineLength: 120,
      // 每行长度
      colors: true,
      // 日志带颜色
      printEmojis: true, // 日志中显示表情符号
    ),
  );

  static void log(String message) {
    logger.d(message);
  }

  static void info(String message) {
    logger.i(message);
  }

  static void error(String message) {
    logger.e(message);
  }

  static void warning(String message) {
    logger.w(message);
  }
}

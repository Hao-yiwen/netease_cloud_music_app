import 'package:logger/logger.dart';

class LogBox {
  static var logger = Logger(
    printer: PrefixPrinter(PrettyPrinter(
      methodCount: 2,
      // Number of method calls to be displayed
      errorMethodCount: 8,
      // Number of method calls if stacktrace is provided
      lineLength: 120,
      // Width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
    )),
  );

  static void debug(String message) {
    logger.d(message);
  }

  static void info(String message) {
    logger.i(message);
  }

  static void error(Object error, {
    dynamic? msg,
  }) {
    logger.e(msg ?? "", error: error);
  }

  static void warning(String message) {
    logger.w(message);
  }
}

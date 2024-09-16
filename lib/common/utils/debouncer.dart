import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    // 如果在规定时间内再次调用，则取消上次定时器
    _timer?.cancel();

    // 创建新的定时器
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
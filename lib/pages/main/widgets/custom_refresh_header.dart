import 'package:easy_refresh/easy_refresh.dart';

class CustomRefreshHeader extends ClassicHeader {
  const CustomRefreshHeader()
      : super(
          dragText: "下拉刷新",
          armedText: "释放刷新",
          processedText: "刷新完成",
          failedText: "刷新失败",
          noMoreText: "没有更多数据",
          readyText: "正在刷新...",
          messageText: "上次刷新时间 %T",
        );
}

import 'dart:math';

import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/timeline/dto/events.dart';
import 'package:netease_cloud_music_app/http/api/timeline/dto/hot_topics.dart';
import 'package:netease_cloud_music_app/http/api/timeline/timeline_api.dart';

class TimelineController extends GetxController {
  Rx<HotTopics> hotTopics = HotTopics().obs;
  RxBool loading = true.obs;
  Rx<Events> hotTopicsEvents = Events().obs;

  static TimelineController get to => Get.find<TimelineController>();

  @override
  void onInit() {
    super.onInit();
    refreshTopics();
  }

  refreshTopics(){
    _getHotTopics();
  }

  _getHotTopics() async {
    try {
      loading.value = true;
      final res = await TimelineApi.getHotTopics();

      hotTopics.value = res;
      if (hotTopics.value.hot != null && hotTopics.value.hot!.isNotEmpty) {
        // 获取热门话题的事件
        final res1 = await TimelineApi.getHotTopicEvents(hotTopics
            .value.hot![Random().nextInt(hotTopics.value.hot!.length)].actId);
        hotTopicsEvents.value = res1;
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }
}

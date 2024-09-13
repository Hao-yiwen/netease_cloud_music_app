import 'package:netease_cloud_music_app/http/api/timeline/dto/events.dart';
import 'package:netease_cloud_music_app/http/api/timeline/dto/hot_topics.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';

class TimelineApi {
  static Future<Events> getUserEvent(int? uid) async {
    final res = await HttpUtils.get("/user/event", params: {"uid": uid});
    return Events.fromJson(res);
  }

  static Future<HotTopics> getHotTopics() async {
    final res = await HttpUtils.get("/hot/topic");
    return HotTopics.fromJson(res);
  }

  static Future<Events> getHotTopicEvents(int? actid) async {
    final res = await HttpUtils.get("/topic/detail/event/hot",
        params: {"actid": actid});
    return Events.fromJson(res);
  }
}

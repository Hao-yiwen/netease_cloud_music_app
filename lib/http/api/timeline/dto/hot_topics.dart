import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'hot_topics.g.dart';

@JsonSerializable()
class HotTopics extends ServerStatusBean {
  List<HotTopic>? hot;

  HotTopics();

  factory HotTopics.fromJson(Map<String, dynamic> json) => _$HotTopicsFromJson(json);

  Map<String, dynamic> toJson() => _$HotTopicsToJson(this);
}

@JsonSerializable()
class HotTopic {
  int? actId;
  String? title;
  List<String>? text;

  HotTopic();

  factory HotTopic.fromJson(Map<String, dynamic> json) => _$HotTopicFromJson(json);

  Map<String, dynamic> toJson() => _$HotTopicToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_topics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotTopics _$HotTopicsFromJson(Map<String, dynamic> json) => HotTopics()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..hot = (json['hot'] as List<dynamic>?)
      ?.map((e) => HotTopic.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$HotTopicsToJson(HotTopics instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'hot': instance.hot,
    };

HotTopic _$HotTopicFromJson(Map<String, dynamic> json) => HotTopic()
  ..actId = (json['actId'] as num?)?.toInt()
  ..title = json['title'] as String?
  ..text = (json['text'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$HotTopicToJson(HotTopic instance) => <String, dynamic>{
      'actId': instance.actId,
      'title': instance.title,
      'text': instance.text,
    };

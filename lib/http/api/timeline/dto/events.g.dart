// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) => Events()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..size = (json['size'] as num?)?.toInt()
  ..events = (json['events'] as List<dynamic>?)
      ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'size': instance.size,
      'events': instance.events,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event()
  ..actName = json['actName'] as String?
  ..json = json['json'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..user = json['user'] == null
      ? null
      : UserProfile.fromJson(json['user'] as Map<String, dynamic>)
  ..eventTime = (json['eventTime'] as num?)?.toInt()
  ..pics = (json['pics'] as List<dynamic>?)
      ?.map((e) => Pic.fromJson(e as Map<String, dynamic>))
      .toList()
  ..actId = (json['actId'] as num?)?.toInt()
  ..bottomActivityInfos = (json['bottomActivityInfos'] as List<dynamic>?)
      ?.map((e) => BottomActivityInfo.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'actName': instance.actName,
      'json': instance.json,
      'id': instance.id,
      'user': instance.user,
      'eventTime': instance.eventTime,
      'pics': instance.pics,
      'actId': instance.actId,
      'bottomActivityInfos': instance.bottomActivityInfos,
    };

Pic _$PicFromJson(Map<String, dynamic> json) => Pic()
  ..height = (json['height'] as num?)?.toInt()
  ..originUrl = json['originUrl'] as String?
  ..squareUrl = json['squareUrl'] as String?
  ..rectangleUrl = json['rectangleUrl'] as String?
  ..width = (json['width'] as num?)?.toInt()
  ..format = json['format'] as String?;

Map<String, dynamic> _$PicToJson(Pic instance) => <String, dynamic>{
      'height': instance.height,
      'originUrl': instance.originUrl,
      'squareUrl': instance.squareUrl,
      'rectangleUrl': instance.rectangleUrl,
      'width': instance.width,
      'format': instance.format,
    };

BottomActivityInfo _$BottomActivityInfoFromJson(Map<String, dynamic> json) =>
    BottomActivityInfo()
      ..id = json['id'] as String?
      ..type = (json['type'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..target = json['target'] as String?
      ..hot = json['hot'] as bool?;

Map<String, dynamic> _$BottomActivityInfoToJson(BottomActivityInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'target': instance.target,
      'hot': instance.hot,
    };

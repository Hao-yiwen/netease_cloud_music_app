// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mv_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MvList _$MvListFromJson(Map<String, dynamic> json) => MvList()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..count = (json['count'] as num?)?.toInt()
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => Mv.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MvListToJson(MvList instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'count': instance.count,
      'data': instance.data,
    };

Mv _$MvFromJson(Map<String, dynamic> json) => Mv()
  ..id = (json['id'] as num?)?.toInt()
  ..cover = json['cover'] as String?
  ..name = json['name'] as String?
  ..playCount = (json['playCount'] as num?)?.toInt()
  ..artistName = json['artistName'] as String?
  ..duration = (json['duration'] as num?)?.toInt();

Map<String, dynamic> _$MvToJson(Mv instance) => <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'name': instance.name,
      'playCount': instance.playCount,
      'artistName': instance.artistName,
      'duration': instance.duration,
    };

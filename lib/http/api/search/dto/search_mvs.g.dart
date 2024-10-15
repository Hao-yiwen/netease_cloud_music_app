// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_mvs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMvs _$SearchMvsFromJson(Map<String, dynamic> json) => SearchMvs()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..result = json['result'] == null
      ? null
      : MvResult.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchMvsToJson(SearchMvs instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

MvResult _$MvResultFromJson(Map<String, dynamic> json) => MvResult()
  ..mvCount = (json['mvCount'] as num?)?.toInt()
  ..mvs = (json['mvs'] as List<dynamic>?)
      ?.map((e) => Mv.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MvResultToJson(MvResult instance) => <String, dynamic>{
      'mvCount': instance.mvCount,
      'mvs': instance.mvs,
    };

Mv _$MvFromJson(Map<String, dynamic> json) => Mv()
  ..id = (json['id'] as num?)?.toInt()
  ..cover = json['cover'] as String?
  ..name = json['name'] as String?
  ..playCount = (json['playCount'] as num?)?.toInt()
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MvToJson(Mv instance) => <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'name': instance.name,
      'playCount': instance.playCount,
      'artists': instance.artists,
    };

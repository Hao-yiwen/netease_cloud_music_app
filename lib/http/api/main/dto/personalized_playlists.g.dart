// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalized_playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizedPlayLists _$PersonalizedPlayListsFromJson(
        Map<String, dynamic> json) =>
    PersonalizedPlayLists()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result = (json['result'] as List<dynamic>?)
          ?.map((e) => RecommendPlaylist.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PersonalizedPlayListsToJson(
        PersonalizedPlayLists instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

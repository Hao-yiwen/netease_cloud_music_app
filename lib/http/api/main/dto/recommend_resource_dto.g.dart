// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_resource_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendResourceDto _$RecommendResourceDtoFromJson(
        Map<String, dynamic> json) =>
    RecommendResourceDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..featureFirst = json['featureFirst'] as bool?
      ..haveRcmdSongs = json['haveRcmdSongs'] as bool?
      ..recommend = (json['recommend'] as List<dynamic>?)
          ?.map((e) => RecommendPlaylist.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RecommendResourceDtoToJson(
        RecommendResourceDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'featureFirst': instance.featureFirst,
      'haveRcmdSongs': instance.haveRcmdSongs,
      'recommend': instance.recommend,
    };

RecommendPlaylist _$RecommendPlaylistFromJson(Map<String, dynamic> json) =>
    RecommendPlaylist()
      ..id = (json['id'] as num?)?.toInt()
      ..type = (json['type'] as num?)?.toInt()
      ..picUrl = json['picUrl'] as String?
      ..playcount = (json['playcount'] as num?)?.toInt()
      ..createTime = (json['createTime'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..creator = json['creator'] == null
          ? null
          : UserProfile.fromJson(json['creator'] as Map<String, dynamic>);

Map<String, dynamic> _$RecommendPlaylistToJson(RecommendPlaylist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'picUrl': instance.picUrl,
      'playcount': instance.playcount,
      'createTime': instance.createTime,
      'name': instance.name,
      'creator': instance.creator,
    };

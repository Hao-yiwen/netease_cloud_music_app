// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..userId = (json['userId'] as num?)?.toInt()
  ..createTime = (json['createTime'] as num?)?.toInt()
  ..updateTime = (json['updateTime'] as num?)?.toInt()
  ..decription = json['decription'] as String?
  ..coverImgUrl = json['coverImgUrl'] as String?
  ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..playCount = (json['playCount'] as num?)?.toInt()
  ..creator = json['creator'] == null
      ? null
      : UserProfile.fromJson(json['creator'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'decription': instance.decription,
      'coverImgUrl': instance.coverImgUrl,
      'tags': instance.tags,
      'playCount': instance.playCount,
      'creator': instance.creator,
    };

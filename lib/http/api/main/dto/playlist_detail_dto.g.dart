// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistDetailDto _$PlaylistDetailDtoFromJson(Map<String, dynamic> json) =>
    PlaylistDetailDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..playlist = json['playlist'] == null
          ? null
          : PlayList.fromJson(json['playlist'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaylistDetailDtoToJson(PlaylistDetailDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlist': instance.playlist,
    };

PlayList _$PlayListFromJson(Map<String, dynamic> json) => PlayList()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..coverImgId = (json['coverImgId'] as num?)?.toInt()
  ..coverImgUrl = json['coverImgUrl'] as String?
  ..userId = (json['userId'] as num?)?.toInt()
  ..createTime = (json['createTime'] as num?)?.toInt()
  ..status = (json['status'] as num?)?.toInt()
  ..playCount = (json['playCount'] as num?)?.toInt()
  ..description = json['description'] as String?
  ..updateFrequency = json['updateFrequency'] as String?
  ..backgroundCoverUrl = json['backgroundCoverUrl'] as String?
  ..titleImageUrl = json['titleImageUrl'] as String?
  ..detailPageTitle = json['detailPageTitle'] as String?
  ..subscribers = (json['subscribers'] as List<dynamic>?)
      ?.map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
      .toList()
  ..creator = json['creator'] == null
      ? null
      : UserProfile.fromJson(json['creator'] as Map<String, dynamic>)
  ..shareCount = (json['shareCount'] as num?)?.toInt()
  ..commentCount = (json['commentCount'] as num?)?.toInt()
  ..score = json['score'] as String?
  ..tracks = (json['tracks'] as List<dynamic>?)
      ?.map((e) => SongDto.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PlayListToJson(PlayList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImgId': instance.coverImgId,
      'coverImgUrl': instance.coverImgUrl,
      'userId': instance.userId,
      'createTime': instance.createTime,
      'status': instance.status,
      'playCount': instance.playCount,
      'description': instance.description,
      'updateFrequency': instance.updateFrequency,
      'backgroundCoverUrl': instance.backgroundCoverUrl,
      'titleImageUrl': instance.titleImageUrl,
      'detailPageTitle': instance.detailPageTitle,
      'subscribers': instance.subscribers,
      'creator': instance.creator,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'score': instance.score,
      'tracks': instance.tracks,
    };

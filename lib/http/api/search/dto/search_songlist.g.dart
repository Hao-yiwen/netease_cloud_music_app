// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_songlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSonglist _$SearchSonglistFromJson(Map<String, dynamic> json) =>
    SearchSonglist()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result = json['result'] == null
          ? null
          : _SongListResult.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchSonglistToJson(SearchSonglist instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

_SongListResult _$SongListResultFromJson(Map<String, dynamic> json) =>
    _SongListResult()
      ..playlistCount = (json['playlistCount'] as num?)?.toInt()
      ..playlists = (json['playlists'] as List<dynamic>?)
          ?.map((e) => playlist.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SongListResultToJson(_SongListResult instance) =>
    <String, dynamic>{
      'playlistCount': instance.playlistCount,
      'playlists': instance.playlists,
    };

playlist _$playlistFromJson(Map<String, dynamic> json) => playlist()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..coverImgUrl = json['coverImgUrl'] as String?
  ..playCount = (json['playCount'] as num?)?.toInt()
  ..creator = json['creator'] == null
      ? null
      : UserProfile.fromJson(json['creator'] as Map<String, dynamic>)
  ..description = json['description'] as String?;

Map<String, dynamic> _$playlistToJson(playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImgUrl': instance.coverImgUrl,
      'playCount': instance.playCount,
      'creator': instance.creator,
      'description': instance.description,
    };

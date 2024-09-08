// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlaylists _$UserPlaylistsFromJson(Map<String, dynamic> json) =>
    UserPlaylists()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..playlist = (json['playlist'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UserPlaylistsToJson(UserPlaylists instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlist': instance.playlist,
    };

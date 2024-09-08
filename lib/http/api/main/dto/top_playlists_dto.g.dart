// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_playlists_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopPlaylistsDto _$TopPlaylistsDtoFromJson(Map<String, dynamic> json) =>
    TopPlaylistsDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..playlists = (json['playlists'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TopPlaylistsDtoToJson(TopPlaylistsDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'playlists': instance.playlists,
    };

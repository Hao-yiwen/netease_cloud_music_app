// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..result = json['result'] == null
      ? null
      : SearchDetail.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchDetail _$SearchDetailFromJson(Map<String, dynamic> json) => SearchDetail()
  ..songCount = (json['songCount'] as num?)?.toInt()
  ..songs = (json['songs'] as List<dynamic>?)
      ?.map((e) => SongDetail.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SearchDetailToJson(SearchDetail instance) =>
    <String, dynamic>{
      'songCount': instance.songCount,
      'songs': instance.songs,
    };

AlbumDto _$AlbumDtoFromJson(Map<String, dynamic> json) => AlbumDto()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?;

Map<String, dynamic> _$AlbumDtoToJson(AlbumDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SongDetail _$SongDetailFromJson(Map<String, dynamic> json) => SongDetail()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
      .toList()
  ..album = json['album'] == null
      ? null
      : AlbumDto.fromJson(json['album'] as Map<String, dynamic>)
  ..duration = (json['duration'] as num?)?.toInt();

Map<String, dynamic> _$SongDetailToJson(SongDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artists': instance.artists,
      'album': instance.album,
      'duration': instance.duration,
    };

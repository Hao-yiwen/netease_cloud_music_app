// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simi_songs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimiSongsDto _$SimiSongsDtoFromJson(Map<String, dynamic> json) => SimiSongsDto()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..songs = (json['songs'] as List<dynamic>?)
      ?.map((e) => SimiSong.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SimiSongsDtoToJson(SimiSongsDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
    };

SimiSong _$SimiSongFromJson(Map<String, dynamic> json) => SimiSong()
  ..popularity = (json['popularity'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..recommendReason = json['recommendReason'] as String?
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SimiSongToJson(SimiSong instance) => <String, dynamic>{
      'popularity': instance.popularity,
      'name': instance.name,
      'id': instance.id,
      'recommendReason': instance.recommendReason,
      'artists': instance.artists,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picUrl = json['picUrl'] as String?
  ..followed = json['followed'] as bool?;

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'followed': instance.followed,
    };

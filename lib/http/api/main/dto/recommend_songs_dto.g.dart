// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_songs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendSongsDto _$RecommendSongsDtoFromJson(Map<String, dynamic> json) =>
    RecommendSongsDto()
      ..dailySongs = (json['dailySongs'] as List<dynamic>?)
          ?.map((e) => SongDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..recommendReasons = (json['recommendReasons'] as List<dynamic>?)
          ?.map((e) => RecommendSongsDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..demote = json['demote'] as bool?;

Map<String, dynamic> _$RecommendSongsDtoToJson(RecommendSongsDto instance) =>
    <String, dynamic>{
      'dailySongs': instance.dailySongs,
      'recommendReasons': instance.recommendReasons,
      'demote': instance.demote,
    };

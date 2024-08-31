// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongDto _$SongDtoFromJson(Map<String, dynamic> json) => SongDto(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      alia: (json['alia'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ar: (json['ar'] as List<dynamic>)
          .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongDtoToJson(SongDto instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'alia': instance.alia,
      'ar': instance.ar,
    };

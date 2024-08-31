// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistDto _$ArtistDtoFromJson(Map<String, dynamic> json) => ArtistDto(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$ArtistDtoToJson(ArtistDto instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

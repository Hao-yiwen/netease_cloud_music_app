// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_fm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalFmDto _$PersonalFmDtoFromJson(Map<String, dynamic> json) =>
    PersonalFmDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..popAdjust = json['popAdjust'] as bool?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => PersonalSongDto.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PersonalFmDtoToJson(PersonalFmDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'popAdjust': instance.popAdjust,
      'data': instance.data,
    };

PersonalSongDto _$PersonalSongDtoFromJson(Map<String, dynamic> json) =>
    PersonalSongDto()
      ..name = json['name'] as String?
      ..id = (json['id'] as num?)?.toInt()
      ..position = (json['position'] as num?)?.toInt()
      ..artists = (json['artists'] as List<dynamic>?)
          ?.map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..popularity = (json['popularity'] as num?)?.toInt()
      ..duration = (json['duration'] as num?)?.toInt();

Map<String, dynamic> _$PersonalSongDtoToJson(PersonalSongDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'position': instance.position,
      'artists': instance.artists,
      'popularity': instance.popularity,
      'duration': instance.duration,
    };

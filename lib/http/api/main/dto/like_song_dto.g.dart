// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeSongDto _$LikeSongDtoFromJson(Map<String, dynamic> json) => LikeSongDto(
      (json['ids'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    )
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$LikeSongDtoToJson(LikeSongDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'ids': instance.ids,
    };

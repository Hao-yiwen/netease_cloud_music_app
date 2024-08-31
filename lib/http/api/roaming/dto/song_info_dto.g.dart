// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongInfoDto _$SongInfoDtoFromJson(Map<String, dynamic> json) => SongInfoDto()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..url = json['url'] as String?
  ..md5 = json['md5'] as String?
  ..time = (json['time'] as num?)?.toInt()
  ..mp3 = json['mp3'] as String?
  ..level = json['level'] as String?;

Map<String, dynamic> _$SongInfoDtoToJson(SongInfoDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'id': instance.id,
      'url': instance.url,
      'md5': instance.md5,
      'time': instance.time,
      'mp3': instance.mp3,
      'level': instance.level,
    };

SongInfoListDto _$SongInfoListDtoFromJson(Map<String, dynamic> json) =>
    SongInfoListDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => SongInfoDto.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SongInfoListDtoToJson(SongInfoListDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

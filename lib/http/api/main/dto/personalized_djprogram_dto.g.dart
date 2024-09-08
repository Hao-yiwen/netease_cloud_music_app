// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalized_djprogram_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizedDjprogramDto _$PersonalizedDjprogramDtoFromJson(
        Map<String, dynamic> json) =>
    PersonalizedDjprogramDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result = (json['result'] as List<dynamic>?)
          ?.map((e) => DjProgram.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PersonalizedDjprogramDtoToJson(
        PersonalizedDjprogramDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

DjProgram _$DjProgramFromJson(Map<String, dynamic> json) => DjProgram()
  ..id = (json['id'] as num?)?.toInt()
  ..type = (json['type'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picUrl = json['picUrl'] as String?
  ..copywriter = json['copywriter'] as String?;

Map<String, dynamic> _$DjProgramToJson(DjProgram instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'copywriter': instance.copywriter,
    };

Program _$ProgramFromJson(Map<String, dynamic> json) => Program()
  ..mainSong = json['mainSong'] == null
      ? null
      : MainSong.fromJson(json['mainSong'] as Map<String, dynamic>)
  ..blurCoverUrl = json['blurCoverUrl'] as String?
  ..coverUrl = json['coverUrl'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..createTime = (json['createTime'] as num?)?.toInt();

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'mainSong': instance.mainSong,
      'blurCoverUrl': instance.blurCoverUrl,
      'coverUrl': instance.coverUrl,
      'id': instance.id,
      'name': instance.name,
      'createTime': instance.createTime,
    };

MainSong _$MainSongFromJson(Map<String, dynamic> json) => MainSong()
  ..name = json['name'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..duration = (json['duration'] as num?)?.toInt();

Map<String, dynamic> _$MainSongToJson(MainSong instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'duration': instance.duration,
    };

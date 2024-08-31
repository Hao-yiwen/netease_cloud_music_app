// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongDto _$SongDtoFromJson(Map<String, dynamic> json) => SongDto()
  ..name = json['name'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..alia = (json['alia'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..ar = (json['ar'] as List<dynamic>?)
      ?.map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
      .toList()
  ..al = json['al'] == null
      ? null
      : Al.fromJson(json['al'] as Map<String, dynamic>);

Map<String, dynamic> _$SongDtoToJson(SongDto instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'alia': instance.alia,
      'ar': instance.ar,
      'al': instance.al,
    };

Al _$AlFromJson(Map<String, dynamic> json) => Al()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picUrl = json['picUrl'] as String?
  ..pic_str = json['pic_str'] as String?
  ..pic = (json['pic'] as num?)?.toInt();

Map<String, dynamic> _$AlToJson(Al instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'pic_str': instance.pic_str,
      'pic': instance.pic,
    };

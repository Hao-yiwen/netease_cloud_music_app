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
  ..dt = (json['dt'] as num?)?.toInt()
  ..fee = (json['fee'] as num?)?.toInt()
  ..al = json['al'] == null
      ? null
      : Al.fromJson(json['al'] as Map<String, dynamic>)
  ..mv = (json['mv'] as num?)?.toInt()
  ..videoInfo = json['videoInfo'] == null
      ? null
      : VideoInfo.fromJson(json['videoInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$SongDtoToJson(SongDto instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'alia': instance.alia,
      'ar': instance.ar,
      'dt': instance.dt,
      'fee': instance.fee,
      'al': instance.al,
      'mv': instance.mv,
      'videoInfo': instance.videoInfo,
    };

SongsDetailDto _$SongsDetailDtoFromJson(Map<String, dynamic> json) =>
    SongsDetailDto()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..songs = (json['songs'] as List<dynamic>?)
          ?.map((e) => SongDto.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SongsDetailDtoToJson(SongsDetailDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'songs': instance.songs,
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

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) => VideoInfo()
  ..video = json['video'] == null
      ? null
      : Video.fromJson(json['video'] as Map<String, dynamic>)
  ..moreThanOne = json['moreThanOne'] as bool?;

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'video': instance.video,
      'moreThanOne': instance.moreThanOne,
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video()
  ..vid = json['vid'] as String?
  ..type = (json['type'] as num?)?.toInt()
  ..title = json['title'] as String?
  ..playTime = (json['playTime'] as num?)?.toInt()
  ..coverUrl = json['coverUrl'] as String?;

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'vid': instance.vid,
      'type': instance.type,
      'title': instance.title,
      'playTime': instance.playTime,
      'coverUrl': instance.coverUrl,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_lyric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongLyric _$SongLyricFromJson(Map<String, dynamic> json) => SongLyric()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..sgc = json['sgc'] as bool?
  ..sfy = json['sfy'] as bool?
  ..qfy = json['qfy'] as bool?
  ..lrc = json['lrc'] == null
      ? null
      : Lyrics.fromJson(json['lrc'] as Map<String, dynamic>)
  ..klyric = json['klyric'] == null
      ? null
      : Lyrics.fromJson(json['klyric'] as Map<String, dynamic>)
  ..tlyric = json['tlyric'] == null
      ? null
      : Lyrics.fromJson(json['tlyric'] as Map<String, dynamic>);

Map<String, dynamic> _$SongLyricToJson(SongLyric instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'sgc': instance.sgc,
      'sfy': instance.sfy,
      'qfy': instance.qfy,
      'lrc': instance.lrc,
      'klyric': instance.klyric,
      'tlyric': instance.tlyric,
    };

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics()
  ..lyric = json['lyric'] as String?
  ..version = (json['version'] as num?)?.toInt();

Map<String, dynamic> _$LyricsToJson(Lyrics instance) => <String, dynamic>{
      'lyric': instance.lyric,
      'version': instance.version,
    };

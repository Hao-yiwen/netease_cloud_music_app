import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'song_lyric.g.dart';

@JsonSerializable()
class SongLyric extends ServerStatusBean {
  bool? sgc;
  bool? sfy;
  bool? qfy;

  Lyrics? lrc;
  Lyrics? klyric;
  Lyrics? tlyric;

  SongLyric();

  factory SongLyric.fromJson(Map<String, dynamic> json) =>
      _$SongLyricFromJson(json);

  Map<String, dynamic> toJson() => _$SongLyricToJson(this);
}

@JsonSerializable()
class Lyrics {
  String? lyric;

  int? version;

  Lyrics();

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);

  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}

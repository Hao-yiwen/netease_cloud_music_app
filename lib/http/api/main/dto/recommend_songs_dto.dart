import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';

part 'recommend_songs_dto.g.dart';

@JsonSerializable()
class RecommendSongsDto {
  List<SongDto>? dailySongs;
  List<RecommendSongsDto>? recommendReasons;
  bool? demote;

  RecommendSongsDto();

  factory RecommendSongsDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongsDtoToJson(this);
}

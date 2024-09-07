import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'like_song_dto.g.dart';

@JsonSerializable()
class LikeSongDto extends ServerStatusBean{
  final List<int> ids;

  LikeSongDto(this.ids);

  factory LikeSongDto.fromJson(Map<String, dynamic> json) => _$LikeSongDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LikeSongDtoToJson(this);
}
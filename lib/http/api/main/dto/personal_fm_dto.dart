import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import 'artist_dto.dart';

part 'personal_fm_dto.g.dart';

@JsonSerializable()
class PersonalFmDto extends ServerStatusBean {
  bool? popAdjust;
  List<PersonalSongDto>? data;

  PersonalFmDto();

  factory PersonalFmDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalFmDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalFmDtoToJson(this);
}

@JsonSerializable()
class PersonalSongDto {
  String? name;
  int? id;
  int? position;
  List<ArtistDto>? artists;
  int? popularity;
  int? duration;

  PersonalSongDto();

  factory PersonalSongDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalSongDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalSongDtoToJson(this);
}
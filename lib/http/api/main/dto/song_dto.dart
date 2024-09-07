import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import 'artist_dto.dart';

part 'song_dto.g.dart';

@JsonSerializable()
class SongDto {
  String? name;
  int? id;
  List<String>? alia;
  List<ArtistDto>? ar;
  Al? al;
  int? mv;
  VideoInfo? videoInfo;

  SongDto();

  factory SongDto.fromJson(Map<String, dynamic> json) =>
      _$SongDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongDtoToJson(this);
}

@JsonSerializable()
class SongsDetailDto extends ServerStatusBean{
  List<SongDto>? songs;

  SongsDetailDto();

  factory SongsDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SongsDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongsDetailDtoToJson(this);
}

@JsonSerializable()
class Al {
  int? id;
  String? name;
  String? picUrl;
  String? pic_str;
  int? pic;

  Al();

  factory Al.fromJson(Map<String, dynamic> json) => _$AlFromJson(json);

  Map<String, dynamic> toJson() => _$AlToJson(this);
}

@JsonSerializable()
class VideoInfo {
  Video? video;
  bool? moreThanOne;

  VideoInfo();

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}

@JsonSerializable()
class Video {
  String? vid;
  int? type;
  String? title;
  int? playTime;
  String? coverUrl;

  Video();

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

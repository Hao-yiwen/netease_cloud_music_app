import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'simi_songs_dto.g.dart';

@JsonSerializable()
class SimiSongsDto extends ServerStatusBean{
  List<SimiSong>? songs;

  SimiSongsDto();

  factory SimiSongsDto.fromJson(Map<String, dynamic> json) => _$SimiSongsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SimiSongsDtoToJson(this);
}

@JsonSerializable()
class SimiSong{
  int? popularity;
  String? name;
  int? id;
  String? recommendReason;
  List<Artist>? artists;

  SimiSong();

  factory SimiSong.fromJson(Map<String, dynamic> json) => _$SimiSongFromJson(json);

  Map<String, dynamic> toJson() => _$SimiSongToJson(this);
}

@JsonSerializable()
class Artist{
  int? id;
  String? name;
  String? picUrl;
  bool? followed;

  Artist();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
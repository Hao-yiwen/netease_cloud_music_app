import 'package:json_annotation/json_annotation.dart';

import 'artist_dto.dart';

part 'song_dto.g.dart';

@JsonSerializable()
class SongDto {
  String? name;
  int? id;
  List<String>? alia;
  List<ArtistDto>? ar;
  Al? al;

  SongDto();

  factory SongDto.fromJson(Map<String, dynamic> json) =>
      _$SongDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongDtoToJson(this);
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

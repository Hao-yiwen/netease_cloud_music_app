import 'package:json_annotation/json_annotation.dart';

import 'artist_dto.dart';

part 'song_dto.g.dart';

@JsonSerializable()
class SongDto{
  String name;
  int id;
  List<String>? alia;
  List<ArtistDto> ar;

  SongDto({required this.name, required this.id, this.alia, required this.ar});

  factory SongDto.fromJson(Map<String, dynamic> json) => _$SongDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongDtoToJson(this);

}
import 'package:json_annotation/json_annotation.dart';

part 'artist_dto.g.dart';

@JsonSerializable()
class ArtistDto {
  final String name;
  final int id;

  ArtistDto({required this.name, required this.id});

  factory ArtistDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDtoToJson(this);
}

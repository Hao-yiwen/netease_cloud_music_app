import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../main/dto/artist_dto.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult extends ServerStatusBean{
  SearchDetail? result;

  SearchResult();

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class SearchDetail {
  int? songCount;

  List<SongDetail>? songs;

  SearchDetail();

  factory SearchDetail.fromJson(Map<String, dynamic> json) => _$SearchDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDetailToJson(this);
}

@JsonSerializable()
class AlbumDto {
  int? id;
  String? name;

  AlbumDto();

  factory AlbumDto.fromJson(Map<String, dynamic> json) => _$AlbumDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDtoToJson(this);
}

@JsonSerializable()
class SongDetail {
  int? id;
  String? name;
  List<ArtistDto>? artists;
  AlbumDto? album;
  int? duration;

  SongDetail();

  factory SongDetail.fromJson(Map<String, dynamic> json) => _$SongDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SongDetailToJson(this);
}


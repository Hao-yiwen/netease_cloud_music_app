import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../main/dto/artist_dto.dart';

part 'search_mvs.g.dart';

@JsonSerializable()
class SearchMvs extends ServerStatusBean{
  MvResult? result;

  SearchMvs();

  factory SearchMvs.fromJson(Map<String, dynamic> json) => _$SearchMvsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMvsToJson(this);
}

@JsonSerializable()
class MvResult {
  int? mvCount;
  List<Mv>? mvs;

  MvResult();

  factory MvResult.fromJson(Map<String, dynamic> json) => _$MvResultFromJson(json);

  Map<String, dynamic> toJson() => _$MvResultToJson(this);
}

@JsonSerializable()
class Mv {
  int? id;
  String? cover;
  String? name;
  int? playCount;
  List<ArtistDto>? artists;

  Mv();

  factory Mv.fromJson(Map<String, dynamic> json) => _$MvFromJson(json);

  Map<String, dynamic> toJson() => _$MvToJson(this);
}
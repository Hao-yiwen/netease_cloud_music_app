import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'search_keys.g.dart';

@JsonSerializable()
class SearchKeys extends ServerStatusBean{
  _SearchResult? result;

  SearchKeys({this.result});

  factory SearchKeys.fromJson(Map<String, dynamic> json) => _$SearchKeysFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeysToJson(this);
}

@JsonSerializable()
class _SearchResult {
  List<MatchItem>? allMatch;

  _SearchResult({this.allMatch});

  factory _SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class MatchItem{
  String? keyword;
  int? type;

  MatchItem({this.keyword, this.type});

  factory MatchItem.fromJson(Map<String, dynamic> json) => _$MatchItemFromJson(json);

  Map<String, dynamic> toJson() => _$MatchItemToJson(this);
}
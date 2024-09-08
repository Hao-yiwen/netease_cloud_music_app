import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';

part 'personalized_playlists.g.dart';

@JsonSerializable()
class PersonalizedPlayLists extends ServerStatusBean{
  List<RecommendPlaylist>? result;

  PersonalizedPlayLists();

  factory PersonalizedPlayLists.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedPlayListsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedPlayListsToJson(this);
}
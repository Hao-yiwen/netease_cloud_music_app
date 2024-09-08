import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../../../models/user/user_profile.dart';

part 'recommend_resource_dto.g.dart';

@JsonSerializable()
class RecommendResourceDto extends ServerStatusBean {
  bool? featureFirst;
  bool? haveRcmdSongs;
  List<RecommendPlaylist>? recommend;

  RecommendResourceDto();

  factory RecommendResourceDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendResourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendResourceDtoToJson(this);
}

@JsonSerializable()
class RecommendPlaylist {
  int? id;
  int? type;
  String? picUrl;
  int? playcount;
  int? createTime;
  String? name;
  UserProfile? creator;

  RecommendPlaylist();

  factory RecommendPlaylist.fromJson(Map<String, dynamic> json) =>
      _$RecommendPlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendPlaylistToJson(this);
}

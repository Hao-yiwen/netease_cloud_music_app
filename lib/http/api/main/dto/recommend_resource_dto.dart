import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../../../models/user/user_profile.dart';

part 'recommend_resource_dto.g.dart';

@JsonSerializable()
class RecommendResourceDto extends ServerStatusBean {
  bool? featureFirst;
  bool? haveRcmdSongs;
  List<RecommendSong>? recommend;

  RecommendResourceDto();

  factory RecommendResourceDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendResourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendResourceDtoToJson(this);
}

@JsonSerializable()
class RecommendSong {
  int? id;
  int? type;
  String? picUrl;
  int? playcount;
  int? createTime;
  String? name;
  UserProfile? creator;

  RecommendSong();

  factory RecommendSong.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongToJson(this);
}

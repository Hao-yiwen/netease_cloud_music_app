import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';
import 'package:netease_cloud_music_app/http/api/user/dto/user_account.dart';

part 'playlist_detail_dto.g.dart';

@JsonSerializable()
class PlaylistDetailDto extends ServerStatusBean {
  PlayList? playlist;

  PlaylistDetailDto();

  factory PlaylistDetailDto.fromJson(Map<String, dynamic> json) => _$PlaylistDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistDetailDtoToJson(this);
}

@JsonSerializable()
class PlayList {
  int? id;
  String? name;
  int? coverImgId;
  String? coverImgUrl;
  int? userId;
  int? createTime;
  int? status;
  int? playCount;
  String? description;
  String? updateFrequency;
  String? backgroundCoverUrl;
  String? titleImageUrl;
  String? detailPageTitle;
  List<UserProfile>? subscribers;
  UserProfile? creator;
  int? shareCount;
  int? commentCount;
  String? score;
  List<SongDto>? tracks;

  PlayList();

  factory PlayList.fromJson(Map<String, dynamic> json) => _$PlayListFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListToJson(this);
}

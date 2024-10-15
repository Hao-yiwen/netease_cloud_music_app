import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../../../models/user/user_profile.dart';
part 'search_songlist.g.dart';

@JsonSerializable()
class SearchSonglist extends ServerStatusBean{
  _SongListResult? result;

  SearchSonglist();

  factory SearchSonglist.fromJson(Map<String, dynamic> json) => _$SearchSonglistFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSonglistToJson(this);
}

@JsonSerializable()
class _SongListResult {
  int? playlistCount;
  List<playlist>? playlists;

  _SongListResult();

  factory _SongListResult.fromJson(Map<String, dynamic> json) => _$SongListResultFromJson(json);
}

@JsonSerializable()
class playlist{
  int? id;
  String? name;
  String? coverImgUrl;
  int? playCount;
  UserProfile? creator;
  String? description;

  playlist();

  factory playlist.fromJson(Map<String, dynamic> json) => _$playlistFromJson(json);

  Map<String, dynamic> toJson() => _$playlistToJson(this);
}
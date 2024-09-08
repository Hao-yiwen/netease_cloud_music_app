import 'package:json_annotation/json_annotation.dart';

import '../../../../models/user/user_profile.dart';

part 'playlist_dto.g.dart';

@JsonSerializable()
class Playlist {
  int? id;
  String? name;
  int? userId;
  int? createTime;
  int? updateTime;
  String? decription;
  String? coverImgUrl;
  List<String>? tags;
  int? playCount;
  UserProfile? creator;

  Playlist();

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
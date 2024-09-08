import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';

part 'user_playlists.g.dart';

@JsonSerializable()
class UserPlaylists extends ServerStatusBean{
  List<Playlist>? playlist;

  UserPlaylists();

  factory UserPlaylists.fromJson(Map<String, dynamic> json) =>
      _$UserPlaylistsFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlaylistsToJson(this);
}
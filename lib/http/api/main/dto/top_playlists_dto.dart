import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';

part 'top_playlists_dto.g.dart';

@JsonSerializable()
class TopPlaylistsDto extends ServerStatusBean{
  List<Playlist>? playlists;

  TopPlaylistsDto();

  factory TopPlaylistsDto.fromJson(Map<String, dynamic> json) =>
      _$TopPlaylistsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TopPlaylistsDtoToJson(this);
}
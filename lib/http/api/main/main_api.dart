import 'package:netease_cloud_music_app/http/api/main/dto/like_song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_detail_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/simi_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';

import '../../http_utils.dart';

class MainApi {
  //获取每日推荐歌曲
  static Future<RecommendSongsDto> getRecommendSongs() async {
    final res = await HttpUtils.get('/recommend/songs');
    return RecommendSongsDto.fromJson(res["data"]);
  }

  //获取每日推荐歌单
  static Future<RecommendResourceDto> getRecommendResource() async {
    final res = await HttpUtils.get('/recommend/resource');
    return RecommendResourceDto.fromJson(res);
  }

  // 获取歌单详情
  static Future<PlaylistDetailDto> getPlaylistDetail(int id) async {
    final res = await HttpUtils.get('/playlist/detail', params: {"id": id});
    return PlaylistDetailDto.fromJson(res);
  }

  // 获取喜欢的音乐
  static Future<LikeSongDto> getLikeSongs() async {
    final res = await HttpUtils.get('/likelist');
    return LikeSongDto.fromJson(res);
  }

  // 获取相似音乐
  static Future<SimiSongsDto> getSimiSongs(int id) async {
    final res = await HttpUtils.get('/simi/song', params: {"id": id});
    return SimiSongsDto.fromJson(res);
  }

  // 获取音乐详情
  static Future<SongsDetailDto> getSongsDetail(String ids) async {
    final res = await HttpUtils.get('/song/detail', params: {"ids": ids});
    return SongsDetailDto.fromJson(res);
  }
}

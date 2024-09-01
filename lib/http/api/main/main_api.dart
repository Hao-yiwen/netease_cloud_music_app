import 'package:netease_cloud_music_app/http/api/main/dto/playlist_detail_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';

import '../../http.dart';
import '../../http_utils.dart';
import '../login/dto/login_status_dto.dart';

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

// 获取歌曲详情
}

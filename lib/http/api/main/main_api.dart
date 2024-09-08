import 'package:netease_cloud_music_app/http/api/main/dto/like_song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personalized_djprogram_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personalized_playlists.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_detail_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/simi_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/top_playlists_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/user_playlists.dart';

import '../../http_utils.dart';
import 'dto/personal_fm_dto.dart';

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

  // 获取私人fm音乐
  static Future<PersonalFmDto> getPersonalFm() async {
    final res = await HttpUtils.get('/personal_fm');
    return PersonalFmDto.fromJson(res);
  }

  // 获取网友推荐顶级歌单
  static Future<TopPlaylistsDto> getTopPlayList() async {
    final res = await HttpUtils.get('/top/playlist', params: {"limit": 10});
    return TopPlaylistsDto.fromJson(res);
  }

  // 推荐歌单
  static Future<PersonalizedPlayLists> getPersonalizedPlaylists() async {
    final res = await HttpUtils.get('/personalized');
    return PersonalizedPlayLists.fromJson(res);
  }

  // 获取用户歌单
  static Future<UserPlaylists> getUserPlaylists(int uid) async {
    final res = await HttpUtils.get('/user/playlist', params: {"uid": uid});
    return UserPlaylists.fromJson(res);
  }

  // 推荐播客
  static Future<PersonalizedDjprogramDto> getDjProgramRecommend() async {
    final res = await HttpUtils.get('/personalized/djprogram');
    return PersonalizedDjprogramDto.fromJson(res);
  }
}

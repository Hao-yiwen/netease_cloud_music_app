import 'dart:math';

import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/like_song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';

import '../../common/constants/keys.dart';
import '../../http/api/main/dto/simi_songs_dto.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;
  Rx<RecommendResourceDto> recommendResourceDto = RecommendResourceDto().obs;
  Rx<List<SongDto>> privateRadarSongs = Rx<List<SongDto>>(<SongDto>[]);
  Rx<LikeSongDto> likeSongDto = LikeSongDto(<int>[]).obs;
  Rx<List<SongDto>> similarSongs = Rx<List<SongDto>>(<SongDto>[]);

  @override
  void onReady() {
    super.onReady();
    _getPrivateRadar();
    _getRecommandSongs();
    _getSameSongsFromSomeRadomMusic();
  }

  _getRecommandSongs() async {
    try {
      loading.value = true;
      recommendSongsDto?.value = await MainApi.getRecommendSongs();
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  _getPrivateRadar() async {
    try {
      loading.value = true;
      // 首先先从推荐资源拿到私人雷达的歌单id
      recommendResourceDto.value = await MainApi.getRecommendResource();
      int privateRadarId = recommendResourceDto.value.recommend?[0]?.id ?? 0;
      if (privateRadarId != 0) {
        // 通过歌单id获取歌曲详细信息
        final playlistDetail = await MainApi.getPlaylistDetail(privateRadarId);
        if (playlistDetail.playlist?.tracks != null) {
          privateRadarSongs.value = playlistDetail.playlist!.tracks!;
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  _getLikeSongs() async {
    try {
      likeSongDto.value = await MainApi.getLikeSongs();
    } catch (e) {
      LogBox.error(e);
    }
  }

  /**
   * 从喜欢的音乐中选择多首音乐，然后生成相似音乐 从相似音乐分别选择6首音译额，共计需要18首音乐
   */
  _getSameSongsFromSomeRadomMusic() async {
    try {
      loading.value = true;
      // 获取喜欢的音乐
      await _getLikeSongs();
      // 从喜欢的音乐中选择多首音乐
      List<int> likeSongIds = likeSongDto.value.ids ?? [];
      if (likeSongIds.isNotEmpty) {
        List<int> threeLikeSongs = [];
        // 从多少首音乐中选择相似音乐
        for (int i = 0; i < RANDOM_SONGS_COUNT; i++) {
          threeLikeSongs.add(likeSongIds[Random().nextInt(likeSongIds.length)]);
        }
        List<SimiSong> simiSongs = [];
        // 生成三首音乐的相似音乐
        for (int id in threeLikeSongs) {
          final simiSongsDto = await MainApi.getSimiSongs(id);
          if (simiSongsDto != null && simiSongsDto.songs!.isNotEmpty) {
            int minLen = min(simiSongsDto.songs!.length, 6);
            for (int i = 0; i < minLen; i++) {
              simiSongs.add(simiSongsDto.songs![i]);
            }
          }
        }
        // 获取18音乐的详细信息
        String ids = "";
        for (int i = 0; i < simiSongs.length; i++) {
          if (simiSongs[i].id != null) {
            ids += simiSongs[i].id.toString();
            if (i != simiSongs.length - 1) {
              ids += ",";
            }
          }
        }
        SongsDetailDto songsDetailDto = await MainApi.getSongsDetail(ids);
        if (songsDetailDto != null && songsDetailDto.songs!.isNotEmpty) {
          // 最多展示18首音乐
          if (songsDetailDto.songs!.length > 18) {
            similarSongs.value = songsDetailDto.songs!.sublist(0, 18);
          } else {
            similarSongs.value = songsDetailDto.songs!;
          }
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }
}

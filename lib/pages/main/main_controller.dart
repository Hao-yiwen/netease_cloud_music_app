import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/like_song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personal_fm_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personalized_djprogram_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personalized_playlists.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/top_playlists_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/user_playlists.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../../common/constants/keys.dart';
import '../../http/api/main/dto/playlist_dto.dart';
import '../../http/api/main/dto/simi_songs_dto.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;

  // 推荐歌曲
  Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;

  // 推荐歌单 包含私人雷达
  Rx<RecommendResourceDto> recommendResourceDto = RecommendResourceDto().obs;

  // 喜欢的音乐
  Rx<LikeSongDto> likeSongDto = LikeSongDto(<int>[]).obs;

  // 获取10个顶级歌单
  Rx<List<Playlist>> topPlayList = Rx<List<Playlist>>(<Playlist>[]);

  // 随机选取的顶级歌单
  Rx<Playlist> randomPlaylist = Rx<Playlist>(Playlist());

  // 推荐歌单
  Rx<List<RecommendPlaylist>> personalizedPlayLists =
      Rx<List<RecommendPlaylist>>(<RecommendPlaylist>[]);

  // 获取用户自己的歌单
  Rx<List<Playlist>> ownPlayList = Rx<List<Playlist>>(<Playlist>[]);

  // 推荐播客
  Rx<PersonalizedDjprogramDto> personalizedDjprogramDto =
      PersonalizedDjprogramDto().obs;

  // 每日推荐歌曲
  RxList<MediaItem> dailySongs = <MediaItem>[].obs;

  // 私人fm推荐音乐
  Rx<List<MediaItem>> personalFmSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  // 私人雷达音乐
  Rx<List<MediaItem>> privateRadarSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  // 红心音乐相似推荐
  Rx<List<MediaItem>> similarSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  // 随机选取的顶级歌单中的全部音乐
  Rx<List<MediaItem>> randomPlaylistSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  static MainController get to => Get.find<MainController>();

  @override
  void onReady() {
    super.onReady();
    refreshMainPage();
  }

  refreshMainPage() {
    // 获取私人雷达
    _getPrivateRadar();
    // 获取推荐歌曲
    _getRecommandSongs();
    // 从喜欢的音乐中选择多首音乐，然后生成相似音乐 从相似音乐分别选择6首音译额，共计需要18首音乐
    _getSameSongsFromSomeRadomMusic();
    // 获取私人fm音乐
    _getPersonalFm();
    // 获取网友推荐顶级歌单
    _getRandomTopPlayList();
    // 获取推荐歌单
    _getPersonalizedPlayLists();
    // 获取个人歌单
    _getOwnPlayList();
    // 获取推荐播客
    getPersonalizedDjProgram();
  }

  _getRecommandSongs() async {
    try {
      loading.value = true;
      recommendSongsDto?.value = await MainApi.getRecommendSongs();
      if (recommendSongsDto.value.dailySongs?.isNotEmpty ?? false) {
        dailySongs.value = RoamingController.to
            .song2ToMedia(recommendSongsDto.value!.dailySongs!);
      }
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
        if (playlistDetail.playlist?.tracks?.isNotEmpty ?? false) {
          privateRadarSongs.value = RoamingController.to
              .song2ToMedia(playlistDetail.playlist!.tracks!);
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

  Future<List<MediaItem>> getPlayListDetail(int id) async {
    try {
      final playlistDetail = await MainApi.getPlaylistDetail(id);
      if (playlistDetail.playlist?.tracks?.isNotEmpty ?? false) {
        return RoamingController.to
            .song2ToMedia(playlistDetail.playlist!.tracks!);
      }
    } catch (e) {
      LogBox.error(e);
    }
    return <MediaItem>[];
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
        if (songsDetailDto.songs?.isNotEmpty ?? false) {
          // 最多展示18首音乐
          if (songsDetailDto.songs!.length > 18) {
            similarSongs.value = RoamingController.to
                .song2ToMedia(songsDetailDto.songs!.sublist(0, 18));
          } else {
            similarSongs.value =
                RoamingController.to.song2ToMedia(songsDetailDto.songs!);
          }
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  _getPersonalFm() async {
    try {
      PersonalFmDto personalFmDto = await MainApi.getPersonalFm();
      if (personalFmDto != null && personalFmDto.data!.isNotEmpty) {
        String ids = "";
        for (int i = 0; i < personalFmDto.data!.length; i++) {
          if (personalFmDto.data![i].id != null) {
            ids += personalFmDto.data![i].id.toString();
            if (i != personalFmDto.data!.length - 1) {
              ids += ",";
            }
          }
        }
        SongsDetailDto songsDetailDto = await MainApi.getSongsDetail(ids);
        if (songsDetailDto.songs?.isNotEmpty ?? false) {
          personalFmSongs.value =
              RoamingController.to.song2ToMedia(songsDetailDto.songs!);
        }
      }
    } catch (e) {
      LogBox.error(e);
    }
  }

  _getRandomTopPlayList() async {
    try {
      loading.value = true;
      // 获取网友推荐顶级歌单
      TopPlaylistsDto topPlaylistsDto = await MainApi.getTopPlayList();
      if (topPlaylistsDto != null && topPlaylistsDto.playlists != null) {
        topPlayList.value = topPlaylistsDto.playlists!;
        // 从歌单随机选取一个歌单
        randomPlaylist.value =
            topPlayList.value[Random().nextInt(topPlayList.value.length)];
        // 获取歌单中的min(18,歌单中的歌曲数量)首歌曲
        final playlistSongs =
            await MainApi.getPlaylistDetail(randomPlaylist.value.id!);
        if (playlistSongs.playlist?.tracks!.isNotEmpty ?? false) {
          if (playlistSongs.playlist!.tracks!.length > 18) {
            randomPlaylistSongs.value = RoamingController.to
                .song2ToMedia(playlistSongs.playlist!.tracks!.sublist(0, 18));
          } else {
            randomPlaylistSongs.value = RoamingController.to
                .song2ToMedia(playlistSongs.playlist!.tracks!);
          }
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  _getPersonalizedPlayLists() async {
    try {
      loading.value = true;
      PersonalizedPlayLists personalizedPlayLists =
          await MainApi.getPersonalizedPlaylists();
      if (personalizedPlayLists != null &&
          personalizedPlayLists.result != null) {
        this.personalizedPlayLists.value = personalizedPlayLists.result!;
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  _getOwnPlayList() async {
    try {
      loading.value = true;
      if (HomeController.to.userData.value.profile != null) {
        UserPlaylists userPlaylists = await MainApi.getUserPlaylists(
            HomeController.to.userData.value.profile!.userId!);
        if (userPlaylists != null && userPlaylists.playlist != null) {
          ownPlayList.value = userPlaylists.playlist!;
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  getPersonalizedDjProgram() async {
    try {
      loading.value = true;
      personalizedDjprogramDto.value = await MainApi.getDjProgramRecommend();
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }
}

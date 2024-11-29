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
  void onInit() {
    super.onInit();
    refreshMainPage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  refreshMainPage() async {
    try {
      loading.value = true;

      // 1. 先并行获取所有原始数据
      final results = await Future.wait([
        MainApi.getRecommendResource(), // 私人雷达资源
        MainApi.getRecommendSongs(), // 推荐歌曲
        MainApi.getLikeSongs(), // 喜欢的音乐
        MainApi.getPersonalFm(), // 私人FM
        MainApi.getTopPlayList(), // 顶级歌单
        MainApi.getPersonalizedPlaylists(), // 个性化歌单推荐
        MainApi.getUserPlaylists(
            HomeController.to.userData.value.profile?.userId ?? 0), // 用户歌单
        MainApi.getDjProgramRecommend(), // 播客推荐
      ]);

      // 2. 处理获取到的数据
      // 处理私人雷达
      recommendResourceDto.value = results[0] as RecommendResourceDto;
      final privateRadarId = recommendResourceDto.value.recommend?[0]?.id ?? 0;
      if (privateRadarId != 0) {
        final playlistDetail = await MainApi.getPlaylistDetail(privateRadarId);
        if (playlistDetail.playlist?.tracks?.isNotEmpty ?? false) {
          privateRadarSongs.value = RoamingController.to
              .song2ToMedia(playlistDetail.playlist!.tracks!);
        }
      }

      // 处理推荐歌曲
      recommendSongsDto.value = results[1] as RecommendSongsDto;
      if (recommendSongsDto.value.dailySongs?.isNotEmpty ?? false) {
        dailySongs.value = RoamingController.to
            .song2ToMedia(recommendSongsDto.value.dailySongs!);
      }

      // 处理喜欢的音乐及相似推荐
      likeSongDto.value = results[2] as LikeSongDto;
      await _processSimilarSongs(likeSongDto.value);

      // 处理私人FM
      final personalFmDto = results[3] as PersonalFmDto;
      await _processPersonalFmSongs(personalFmDto);

      // 处理顶级歌单
      final topPlaylistsDto = results[4] as TopPlaylistsDto;
      await _processTopPlaylist(topPlaylistsDto);

      // 处理个性化歌单推荐
      final personalizedPlayLists = results[5] as PersonalizedPlayLists;
      if (personalizedPlayLists.result != null) {
        this.personalizedPlayLists.value = personalizedPlayLists.result!;
      }

      // 处理用户歌单
      final userPlaylists = results[6] as UserPlaylists;
      if (userPlaylists.playlist != null) {
        ownPlayList.value = userPlaylists.playlist!;
      }

      // 处理播客推荐
      personalizedDjprogramDto.value = results[7] as PersonalizedDjprogramDto;
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

// 处理相似歌曲的逻辑
  Future<void> _processSimilarSongs(LikeSongDto likeSongDto) async {
    final likeSongIds = likeSongDto.ids ?? [];
    if (likeSongIds.isEmpty) return;

    final threeLikeSongs = _getRandomSongs(likeSongIds, RANDOM_SONGS_COUNT);
    final simiSongs = await _getSimiSongsForIds(threeLikeSongs);
    await _processSimiSongsDetail(simiSongs);
  }

  // 从列表中随机获取指定数量的歌曲ID
  List<int> _getRandomSongs(List<int> songIds, int count) {
    if (songIds.isEmpty || count <= 0) return [];

    final random = Random();
    final selectedIds = <int>[];

    while (selectedIds.length < count && selectedIds.length < songIds.length) {
      final randomId = songIds[random.nextInt(songIds.length)];
      if (!selectedIds.contains(randomId)) {
        selectedIds.add(randomId);
      }
    }

    return selectedIds;
  }

// 获取相似歌曲
  Future<List<SimiSong>> _getSimiSongsForIds(List<int> songIds) async {
    final List<SimiSong> allSimiSongs = [];

    for (final id in songIds) {
      try {
        final simiSongsDto = await MainApi.getSimiSongs(id);
        if (simiSongsDto?.songs?.isNotEmpty ?? false) {
          // 每个ID最多取6首相似歌曲
          final count = min(simiSongsDto!.songs!.length, 6);
          allSimiSongs.addAll(simiSongsDto.songs!.sublist(0, count));
        }
      } catch (e) {
        LogBox.error(e);
      }
    }

    return allSimiSongs;
  }

// 处理相似歌曲的详细信息
  Future<void> _processSimiSongsDetail(List<SimiSong> simiSongs) async {
    if (simiSongs.isEmpty) return;

    try {
      // 构建ID字符串
      final ids = simiSongs.map((song) => song.id.toString()).join(',');

      // 获取歌曲详情
      final songsDetailDto = await MainApi.getSongsDetail(ids);
      if (songsDetailDto.songs?.isNotEmpty ?? false) {
        // 最多展示18首音乐
        final songs = songsDetailDto.songs!;
        similarSongs.value = RoamingController.to
            .song2ToMedia(songs.length > 18 ? songs.sublist(0, 18) : songs);
      }
    } catch (e) {
      LogBox.error(e);
    }
  }

// 处理私人FM歌曲的逻辑
  Future<void> _processPersonalFmSongs(PersonalFmDto personalFmDto) async {
    if (personalFmDto.data?.isEmpty ?? true) return;

    final ids = personalFmDto.data!.map((item) => item.id.toString()).join(',');

    final songsDetailDto = await MainApi.getSongsDetail(ids);
    if (songsDetailDto.songs?.isNotEmpty ?? false) {
      personalFmSongs.value =
          RoamingController.to.song2ToMedia(songsDetailDto.songs!);
    }
  }

// 处理顶级歌单的逻辑
  Future<void> _processTopPlaylist(TopPlaylistsDto topPlaylistsDto) async {
    if (topPlaylistsDto.playlists?.isEmpty ?? true) return;

    topPlayList.value = topPlaylistsDto.playlists!;
    randomPlaylist.value =
        topPlayList.value[Random().nextInt(topPlayList.value.length)];

    final playlistSongs =
        await MainApi.getPlaylistDetail(randomPlaylist.value.id!);

    if (playlistSongs.playlist?.tracks?.isNotEmpty ?? false) {
      final tracks = playlistSongs.playlist!.tracks!;
      randomPlaylistSongs.value = RoamingController.to
          .song2ToMedia(tracks.length > 18 ? tracks.sublist(0, 18) : tracks);
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

  getPersonalizedDjProgram() async {
    try {
      personalizedDjprogramDto.value = await MainApi.getDjProgramRecommend();
    } catch (e) {
      LogBox.error(e);
    }
  }
}

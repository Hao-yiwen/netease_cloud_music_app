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
import 'package:netease_cloud_music_app/http/api/main/dto/top_playlists_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/user_playlists.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/simi_songs_dto.dart';

// 定义控制器状态枚举
enum MainControllerState { initial, initializing, ready, error }

class MainController extends GetxController {
  // 状态管理
  final Rx<MainControllerState> _state = MainControllerState.initial.obs;
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;

  // 数据存储
  final Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;
  final Rx<RecommendResourceDto> recommendResourceDto =
      RecommendResourceDto().obs;
  final Rx<LikeSongDto> likeSongDto = LikeSongDto(<int>[]).obs;
  final Rx<List<Playlist>> topPlayList = Rx<List<Playlist>>(<Playlist>[]);
  final Rx<Playlist> randomPlaylist = Rx<Playlist>(Playlist());
  final Rx<List<RecommendPlaylist>> personalizedPlayLists =
      Rx<List<RecommendPlaylist>>(<RecommendPlaylist>[]);
  final Rx<List<Playlist>> ownPlayList = Rx<List<Playlist>>(<Playlist>[]);
  final Rx<PersonalizedDjprogramDto> personalizedDjprogramDto =
      PersonalizedDjprogramDto().obs;

  // 音乐相关数据
  final RxList<MediaItem> dailySongs = <MediaItem>[].obs;
  final Rx<List<MediaItem>> personalFmSongs =
      Rx<List<MediaItem>>(<MediaItem>[]);
  final Rx<List<MediaItem>> privateRadarSongs =
      Rx<List<MediaItem>>(<MediaItem>[]);
  final Rx<List<MediaItem>> similarSongs = Rx<List<MediaItem>>(<MediaItem>[]);
  final Rx<List<MediaItem>> randomPlaylistSongs =
      Rx<List<MediaItem>>(<MediaItem>[]);

  // 获取实例的静态方法
  static MainController get to => Get.find<MainController>();

  // Getters
  bool get isLoading => loading.value;
  bool get hasError => _state.value == MainControllerState.error;
  String get error => errorMessage.value;
  bool get isReady => _state.value == MainControllerState.ready;

  @override
  void onInit() {
    super.onInit();
    _state.value = MainControllerState.initializing;
    initData();
  }

  Future<void> initData() async {
    try {
      await refreshMainPage();
      _state.value = MainControllerState.ready;
    } catch (e) {
      _state.value = MainControllerState.error;
      errorMessage.value = e.toString();
      LogBox.error('初始化失败: $e');
    }
  }

  Future<void> refreshMainPage() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      // 并行获取所有数据
      final results = await Future.wait([
        _safeApiCall(() => MainApi.getRecommendResource(), '推荐资源获取失败'),
        _safeApiCall(() => MainApi.getRecommendSongs(), '推荐歌曲获取失败'),
        _safeApiCall(() => MainApi.getLikeSongs(), '喜欢的音乐获取失败'),
        _safeApiCall(() => MainApi.getPersonalFm(), '私人FM获取失败'),
        _safeApiCall(() => MainApi.getTopPlayList(), '顶级歌单获取失败'),
        _safeApiCall(() => MainApi.getPersonalizedPlaylists(), '个性化歌单获取失败'),
        _safeApiCall(
            () => MainApi.getUserPlaylists(
                HomeController.to.userData.value.profile?.userId ?? 0),
            '用户歌单获取失败'),
        _safeApiCall(() => MainApi.getDjProgramRecommend(), '播客推荐获取失败'),
      ]);

      // 处理获取到的数据
      await _processResults(results);
    } catch (e) {
      errorMessage.value = '刷新失败: $e';
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  // 安全的API调用包装方法
  Future<T> _safeApiCall<T>(
      Future<T> Function() apiCall, String errorMessage) async {
    try {
      return await apiCall();
    } catch (e) {
      LogBox.error('$errorMessage: $e');
      throw errorMessage;
    }
  }

  // 处理API返回的结果
  Future<void> _processResults(List<dynamic> results) async {
    try {
      // 处理推荐资源
      await _processRecommendResource(results[0] as RecommendResourceDto);

      // 处理推荐歌曲
      await _processRecommendSongs(results[1] as RecommendSongsDto);

      // 处理喜欢的歌曲
      await _processLikeSongs(results[2] as LikeSongDto);

      // 处理私人FM
      await _processPersonalFm(results[3] as PersonalFmDto);

      // 处理顶级歌单
      await _processTopPlaylist(results[4] as TopPlaylistsDto);

      // 处理个性化推荐歌单
      _processPersonalizedPlaylists(results[5] as PersonalizedPlayLists);

      // 处理用户歌单
      _processUserPlaylists(results[6] as UserPlaylists);

      // 处理播客推荐
      _processDjProgram(results[7] as PersonalizedDjprogramDto);
    } catch (e) {
      LogBox.error('处理数据失败: $e');
      throw '数据处理失败';
    }
  }

  // 处理推荐资源
  Future<void> _processRecommendResource(RecommendResourceDto dto) async {
    recommendResourceDto.value = dto;
    final privateRadarId = dto.recommend?[0]?.id;
    if (privateRadarId != null) {
      await _loadPrivateRadarSongs(privateRadarId);
    }
  }

  // 加载私人雷达歌曲
  Future<void> _loadPrivateRadarSongs(int privateRadarId) async {
    try {
      final playlistDetail = await MainApi.getPlaylistDetail(privateRadarId);
      if (playlistDetail.playlist?.tracks?.isNotEmpty ?? false) {
        privateRadarSongs.value =
            RoamingController.to.song2ToMedia(playlistDetail.playlist!.tracks!);
      }
    } catch (e) {
      LogBox.error('加载私人雷达歌曲失败: $e');
    }
  }

  // 处理推荐歌曲
  Future<void> _processRecommendSongs(RecommendSongsDto dto) async {
    recommendSongsDto.value = dto;
    if (dto.dailySongs?.isNotEmpty ?? false) {
      dailySongs.value = RoamingController.to.song2ToMedia(dto.dailySongs!);
    }
  }

  // 处理喜欢的歌曲
  Future<void> _processLikeSongs(LikeSongDto dto) async {
    likeSongDto.value = dto;
    await _processSimilarSongs(dto);
  }

  // 处理相似歌曲
  Future<void> _processSimilarSongs(LikeSongDto dto) async {
    final likeSongIds = dto.ids ?? [];
    if (likeSongIds.isEmpty) return;

    try {
      final selectedIds = _getRandomSongs(likeSongIds, RANDOM_SONGS_COUNT);
      final simiSongs = await _getSimiSongsForIds(selectedIds);
      await _processSimiSongsDetail(simiSongs);
    } catch (e) {
      LogBox.error('处理相似歌曲失败: $e');
    }
  }

  // 随机获取歌曲
  List<int> _getRandomSongs(List<int> songIds, int count) {
    if (songIds.isEmpty || count <= 0) return [];

    final random = Random();
    final selectedIds = <int>[];
    final availableIds = List<int>.from(songIds);

    while (selectedIds.length < count && availableIds.isNotEmpty) {
      final index = random.nextInt(availableIds.length);
      selectedIds.add(availableIds[index]);
      availableIds.removeAt(index);
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
          final count = min(simiSongsDto!.songs!.length, 6);
          allSimiSongs.addAll(simiSongsDto.songs!.sublist(0, count));
        }
      } catch (e) {
        LogBox.error('获取相似歌曲失败: $e');
      }
    }

    return allSimiSongs;
  }

  // 处理相似歌曲详情
  Future<void> _processSimiSongsDetail(List<SimiSong> simiSongs) async {
    if (simiSongs.isEmpty) return;

    try {
      final ids = simiSongs.map((song) => song.id.toString()).join(',');
      final songsDetailDto = await MainApi.getSongsDetail(ids);

      if (songsDetailDto.songs?.isNotEmpty ?? false) {
        final songs = songsDetailDto.songs!;
        similarSongs.value = RoamingController.to
            .song2ToMedia(songs.length > 18 ? songs.sublist(0, 18) : songs);
      }
    } catch (e) {
      LogBox.error('处理相似歌曲详情失败: $e');
    }
  }

  // 处理私人FM
  Future<void> _processPersonalFm(PersonalFmDto dto) async {
    if (dto.data?.isEmpty ?? true) return;

    try {
      final ids = dto.data!.map((item) => item.id.toString()).join(',');
      final songsDetailDto = await MainApi.getSongsDetail(ids);

      if (songsDetailDto.songs?.isNotEmpty ?? false) {
        personalFmSongs.value =
            RoamingController.to.song2ToMedia(songsDetailDto.songs!);
      }
    } catch (e) {
      LogBox.error('处理私人FM失败: $e');
    }
  }

  // 处理顶级歌单
  Future<void> _processTopPlaylist(TopPlaylistsDto dto) async {
    if (dto.playlists?.isEmpty ?? true) {
      LogBox.error('顶级歌单为空');
      return;
    }

    try {
      topPlayList.value = dto.playlists!;

      if (topPlayList.value.isNotEmpty) {
        randomPlaylist.value =
            topPlayList.value[Random().nextInt(topPlayList.value.length)];
        await _loadRandomPlaylistSongs();
      }
    } catch (e) {
      LogBox.error('处理顶级歌单失败: $e');
    }
  }

  // 加载随机歌单歌曲
  Future<void> _loadRandomPlaylistSongs() async {
    if (randomPlaylist.value.id == null) return;

    try {
      final playlistSongs =
          await MainApi.getPlaylistDetail(randomPlaylist.value.id!);

      if (playlistSongs.playlist?.tracks?.isNotEmpty ?? false) {
        final tracks = playlistSongs.playlist!.tracks!;
        randomPlaylistSongs.value = RoamingController.to
            .song2ToMedia(tracks.length > 18 ? tracks.sublist(0, 18) : tracks);
      }
    } catch (e) {
      LogBox.error('加载随机歌单歌曲失败: $e');
    }
  }

  // 处理个性化推荐歌单
  void _processPersonalizedPlaylists(PersonalizedPlayLists dto) {
    if (dto.result != null) {
      personalizedPlayLists.value = dto.result!;
    }
  }

  // 处理用户歌单
  void _processUserPlaylists(UserPlaylists dto) {
    if (dto.playlist != null) {
      ownPlayList.value = dto.playlist!;
    }
  }

  // 处理播客推荐
  void _processDjProgram(PersonalizedDjprogramDto dto) {
    personalizedDjprogramDto.value = dto;
  }

  // 公共方法
  Future<List<MediaItem>> getPlayListDetail(int id) async {
    try {
      loading.value = true;
      final playlistDetail = await MainApi.getPlaylistDetail(id);

      if (playlistDetail.playlist?.tracks?.isNotEmpty ?? false) {
        return RoamingController.to
            .song2ToMedia(playlistDetail.playlist!.tracks!, playlistDetail: playlistDetail);
      }
    } catch (e) {
      LogBox.error('获取歌单详情失败: $e');
      errorMessage.value = '获取歌单详情失败';
    } finally {
      loading.value = false;
    }
    return <MediaItem>[];
  }

  // 获取个性化播客推荐
  Future<void> getPersonalizedDjProgram() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      final dto = await MainApi.getDjProgramRecommend();
      _processDjProgram(dto);
    } catch (e) {
      errorMessage.value = '获取播客推荐失败';
      LogBox.error('获取播客推荐失败: $e');
    } finally {
      loading.value = false;
    }
  }

  // 重试加载顶级歌单
  Future<void> retryLoadTopPlaylist() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      final topPlaylistsDto = await MainApi.getTopPlayList();
      await _processTopPlaylist(topPlaylistsDto);

      _state.value = MainControllerState.ready;
    } catch (e) {
      _state.value = MainControllerState.error;
      errorMessage.value = '重试加载顶级歌单失败';
      LogBox.error('重试加载顶级歌单失败: $e');
    } finally {
      loading.value = false;
    }
  }

  // 刷新私人FM
  Future<void> refreshPersonalFm() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      final personalFmDto = await MainApi.getPersonalFm();
      await _processPersonalFm(personalFmDto);
    } catch (e) {
      errorMessage.value = '刷新私人FM失败';
      LogBox.error('刷新私人FM失败: $e');
    } finally {
      loading.value = false;
    }
  }

  // 刷新推荐歌单
  Future<void> refreshRecommendPlaylist() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      final recommendResourceDto = await MainApi.getRecommendResource();
      await _processRecommendResource(recommendResourceDto);
    } catch (e) {
      errorMessage.value = '刷新推荐歌单失败';
      LogBox.error('刷新推荐歌单失败: $e');
    } finally {
      loading.value = false;
    }
  }

  // 刷新播客推荐
  Future<void> refreshDjProgram() async {
    try {
      loading.value = true;
      errorMessage.value = '';

      final dto = await MainApi.getDjProgramRecommend();
      _processDjProgram(dto);
    } catch (e) {
      errorMessage.value = '刷新播客推荐失败';
      LogBox.error('刷新播客推荐失败: $e');
    } finally {
      loading.value = false;
    }
  }

  // 添加错误处理方法
  void handleError(dynamic error, {String prefix = '操作失败'}) {
    final message = error?.toString() ?? '未知错误';
    errorMessage.value = '$prefix: $message';
    _state.value = MainControllerState.error;
    LogBox.error('$prefix: $message');
  }

  // 清理错误状态
  void clearError() {
    errorMessage.value = '';
    if (_state.value == MainControllerState.error) {
      _state.value = MainControllerState.ready;
    }
  }

  // 资源释放
  @override
  void onClose() {
    // 清理所有数据
    recommendSongsDto.value = RecommendSongsDto();
    recommendResourceDto.value = RecommendResourceDto();
    likeSongDto.value = LikeSongDto(<int>[]);
    topPlayList.value = <Playlist>[];
    randomPlaylist.value = Playlist();
    personalizedPlayLists.value = <RecommendPlaylist>[];
    ownPlayList.value = <Playlist>[];
    personalizedDjprogramDto.value = PersonalizedDjprogramDto();
    dailySongs.clear();
    personalFmSongs.value = <MediaItem>[];
    privateRadarSongs.value = <MediaItem>[];
    similarSongs.value = <MediaItem>[];
    randomPlaylistSongs.value = <MediaItem>[];

    super.onClose();
  }
}

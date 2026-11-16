import 'dart:async';
import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:netease_cloud_music_app/common/lyric_parser/LyricsLineModel.dart';
import 'package:netease_cloud_music_app/common/lyric_parser/parser_lrc.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/comment_music.dart';
import 'package:netease_cloud_music_app/http/api/roaming/roaming_api.dart';

import '../../common/constants/keys.dart';
import '../../common/music_handler.dart';
import '../../http/api/login/dto/login_status_dto.dart';
import '../../http/api/main/dto/playlist_detail_dto.dart';
import '../../http/api/main/dto/song_dto.dart';
import '../user/user_controller.dart';

class RoamingController extends SuperController
    with GetSingleTickerProviderStateMixin {
  final box = GetIt.instance<Box>();
  RxBool loading = false.obs;

  // 歌词 播放列表pageview下标
  RxInt selectIndex = 0.obs;

  // audio handler
  final audioHandler = GetIt.instance<MusicHandler>();

  // 当前播放歌曲
  Rx<MediaItem> mediaItem =
      const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;

  // 当前播放列表
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;

  // 是否播放中
  RxBool playing = false.obs;

  // 是否是fm
  RxBool fm = false.obs;

  // 播放进度
  Rx<Duration> duration = Duration.zero.obs;
  Duration lastDuration = Duration.zero;

  // 循环方式
  Rx<AudioServiceRepeatMode> audioServiceRepeatMode =
      AudioServiceRepeatMode.all.obs;

  // 是否开启高音质
  RxBool high = false.obs;

  //用户喜欢
  RxList<int> likeIds = <int>[].obs;
  Rx<LoginStatus> loginStatus = LoginStatus.noLogin.obs;
  Rx<LoginStatusDto> userData = LoginStatusDto().obs;

  //路由相关
  AutoRouterDelegate? autoRouterDelegate;

  //上下文
  late BuildContext buildContext;

  RxString currPathUrl = '/home/user'.obs;

  var lastPopTime = DateTime.now();

  // 歌曲评论
  RxList<CommentSection> comments = <CommentSection>[].obs;
  RxInt commentCount = 0.obs;

  // 歌曲歌词
  RxBool hasTran = false.obs;

  List<LyricsLineModel> lyricLineModels = <LyricsLineModel>[].obs;
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @override
  void onInit() {
    super.onInit();
    String repeatMode = box.get(REPEAT_MODE, defaultValue: 'all');
    audioServiceRepeatMode.value = AudioServiceRepeatMode.values
            .firstWhereOrNull((element) => element.name == repeatMode) ??
        AudioServiceRepeatMode.all;
  }

  @override
  void onReady() {
    super.onReady();
    _initUserData();
    _initHomeData();
  }

  void _initUserData() {
    String userDataStr = box.get(LOGIN_DATA) ?? '';
    if (userDataStr.isNotEmpty) {
      loginStatus.value = LoginStatus.login;
      userData.value = LoginStatusDto.fromJson(jsonDecode(userDataStr));
    }
  }

  _initHomeData() {
    autoRouterDelegate = AutoRouterDelegate.of(buildContext);

    autoRouterDelegate?.addListener(listenRouter);

    _subscriptions.add(audioHandler.queue.listen((value) => mediaItems
      ..clear()
      ..addAll(value)));

    _subscriptions.add(audioHandler.mediaItem.listen((value) async {
      lyricLineModels.clear();
      comments.clear();
      commentCount.value = 0;
      duration.value = Duration.zero;
      if (value == null) return;
      mediaItem.value = value;
      _getMusicLyric(value.id);

      if (value.extras?['type'] == MediaType.playlist.name) {
        _getMusicComment();
      }
    }));

    _subscriptions.add(AudioService.createPositionStream(
      minPeriod: const Duration(milliseconds: 200),
      maxPeriod: const Duration(milliseconds: 500),
    ).listen((event) {
      final total = mediaItem.value.duration ?? Duration.zero;
      if (total > Duration.zero && event > total) {
        duration.value = Duration.zero;
        return;
      }
      duration.value = event;
    }));

    _subscriptions.add(audioHandler.playbackState.listen((value) {
      playing.value = value.playing;
    }));
  }

  listenRouter() {
    String path = autoRouterDelegate?.urlState.url ?? '';
    if (path == '/home/user' ||
        path == '/home/index' ||
        path == '/home/local' ||
        path == '/home/settingL') {
      currPathUrl.value = path;
    }
  }

  void playOrPause() async {
    if (playing.value) {
      await audioHandler.pause();
    } else {
      await audioHandler.play();
    }
  }

  playByIndex(int index, String queueTitle,
      {List<MediaItem>? mediaItem}) async {
    audioHandler.queueTitle.value = queueTitle;
    audioHandler.changeQueueLists(mediaItem ?? [], index: index);
  }

  static RoamingController get to => Get.find<RoamingController>();

  List<MediaItem> song2ToMedia(List<SongDto> songs,
      {PlaylistDetailDto? playlistDetail}) {
    return songs
        .map((e) => MediaItem(
            id: e.id.toString(),
            duration: Duration(milliseconds: e.dt ?? 0),
            artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
            extras: {
              'type': MediaType.playlist.name,
              'image': e.al?.picUrl ?? '',
              'liked': likeIds.contains(int.tryParse(e.id.toString())),
              'artist': (e.ar ?? [])
                  .map((e) => jsonEncode(e.toJson()))
                  .toList()
                  .join(' / '),
              'album': jsonEncode(e.al?.toJson()),
              'mv': e.mv,
              'fee': e.fee,
              'title': playlistDetail?.playlist?.name ?? '',
            },
            title: e.name ?? "",
            album: e.al?.name,
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
  }

  // 防治重复点击
  bool intervalClick() {
    if (DateTime.now().difference(lastPopTime) >
        const Duration(milliseconds: 300)) {
      lastPopTime = DateTime.now();
      return true;
    }
    return false;
  }

  Future<void> changeRepeatMode() async {
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.none;
        break;
      case AudioServiceRepeatMode.none:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.one;
        break;
    }
    audioHandler.setRepeatMode(audioServiceRepeatMode.value);
    box.put(REPEAT_MODE, audioServiceRepeatMode.value.name);
  }

  IconData getRepeatIcon() {
    IconData icon;
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        icon = TablerIcons.repeat_once;
        break;
      case AudioServiceRepeatMode.none:
        icon = TablerIcons.arrows_shuffle;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        icon = TablerIcons.repeat;
        break;
    }
    return icon;
  }

  @override
  void onClose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    autoRouterDelegate?.removeListener(listenRouter);
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  Future<void> _getMusicComment() async {
    final songId = mediaItem.value.id;
    comments.clear();
    commentCount.value = 0;
    try {
      final commentMusic = await RoamingApi.getMusicComment(songId);
      if (mediaItem.value.id != songId || commentMusic.code != 200) return;
      commentCount.value = commentMusic.total ?? 0;
      final sections = <CommentSection>[];
      if (commentMusic.topComments?.isNotEmpty ?? false) {
        sections.add(CommentSection()
          ..title = '置顶评论'
          ..comments = commentMusic.topComments!);
      }
      if (commentMusic.hotComments?.isNotEmpty ?? false) {
        sections.add(CommentSection()
          ..title = '热门评论'
          ..comments = commentMusic.hotComments!);
      }
      if (commentMusic.comments?.isNotEmpty ?? false) {
        sections.add(CommentSection()
          ..title = '最新评论'
          ..comments = commentMusic.comments!);
      }
      comments.assignAll(sections);
    } catch (e) {
      LogBox.error(e);
    }
  }

  void _publishLyrics(String songId, String lyric, String lyricTran) {
    if (mediaItem.value.id != songId) return;
    lyricLineModels.clear();
    if (lyric.isEmpty) {
      hasTran.value = false;
      return;
    }
    final list = ParserLrc(lyric).parseLines();
    final listTran = ParserLrc(lyricTran).parseLines();
    hasTran.value = lyricTran.isNotEmpty;
    if (lyricTran.isNotEmpty) {
      lyricLineModels.addAll(list.map((line) {
        final index = listTran
            .indexWhere((element) => element.startTime == line.startTime);
        if (index != -1) {
          line.extText = listTran[index].mainText;
        }
        return line;
      }).toList());
    } else {
      lyricLineModels.addAll(list);
    }
  }

  Future<void> _getMusicLyric(String id) async {
    try {
      hasTran.value = false;
      final cached = box.get('lyric_$id');
      final cachedTran = box.get('lyricTran_$id');
      if (cached is String && cached.isNotEmpty) {
        _publishLyrics(id, cached, cachedTran is String ? cachedTran : '');
      }
      final songLyric = await RoamingApi.getMusicLyric(id);
      if (mediaItem.value.id != id) return;
      final lyric = songLyric.lrc?.lyric ?? '';
      final lyricTran = songLyric.tlyric?.lyric ?? '';
      box.put('lyric_$id', lyric);
      box.put('lyricTran_$id', lyricTran);
      _publishLyrics(id, lyric, lyricTran);
    } catch (e) {
      LogBox.error(e);
    }
  }
}

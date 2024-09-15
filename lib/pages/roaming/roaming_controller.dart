import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_info_dto.dart';
import 'package:netease_cloud_music_app/http/api/roaming/roaming_api.dart';

import '../../common/constants/keys.dart';
import '../../common/music_handler.dart';
import '../../http/api/login/dto/login_status_dto.dart';
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

    audioHandler.queue.listen((value) => mediaItems
      ..clear()
      ..addAll(value));

    audioHandler.mediaItem.listen((value) async {
      duration.value = Duration.zero;
      if (value == null) return;
      mediaItem.value = value;
    });

    AudioService.createPositionStream(
            minPeriod: const Duration(microseconds: 800), steps: 1000)
        .listen((event) {
      if (event.inMicroseconds >
          (mediaItem.value.duration?.inMicroseconds ?? 0)) {
        {
          duration.value = Duration.zero;
          return;
        }
      }
      duration.value = event;
    });

    audioHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });
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

  List<MediaItem> song2ToMedia(List<SongDto> songs) {
    return songs
        .map((e) => MediaItem(
            id: e!.id.toString(),
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
              'fee': e.fee
            },
            title: e.name ?? "",
            album: e.al?.name,
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
  }

  @override
  void onClose() {
    super.onClose();

    autoRouterDelegate?.removeListener(listenRouter);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

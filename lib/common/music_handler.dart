import 'dart:async';
import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:netease_cloud_music_app/common/audio_player_handler.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../http/api/roaming/roaming_api.dart';
import 'constants/keys.dart';
import 'constants/platform_utils.dart';
import 'playback_cursor.dart';

/// @date 2024/0914
/// @desc 音乐播放handler
/// @refrence 参考bujuan音乐播放逻辑
Future<List<MediaItem>> getCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  List<MediaItem> items = data.playList?.map((e) {
        var map = MediaItemMessage.fromMap(jsonDecode(e));
        return MediaItem(
          id: map.id,
          duration: map.duration,
          artUri: map.artUri,
          extras: map.extras,
          title: map.title,
          artist: map.artist,
          album: map.album,
        );
      }).toList() ??
      [];

  return items;
}

Future<List<String>> setCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  return data.items
          ?.map((e) => jsonEncode(MediaItemMessage(
                id: e.id,
                album: e.album,
                title: e.title,
                artist: e.artist,
                duration: e.duration,
                artUri: e.artUri,
                extras: e.extras,
              ).toMap()))
          .toList() ??
      [];
}

class RootIsolateData {
  RootIsolateToken rootIsolateToken;
  List<String>? playList;
  List<MediaItem>? items;

  RootIsolateData(this.rootIsolateToken, {this.playList, this.items});
}

class MusicHandler extends BaseAudioHandler
    with SeekHandler, QueueHandler
    implements AudioPlayerHandler {
  final AudioPlayer _audioPlayer = GetIt.instance<AudioPlayer>();
  final Box _box = GetIt.instance<Box>();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  final _playList = <MediaItem>[];
  final _playListShut = <MediaItem>[];
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  AudioServiceRepeatMode _audioServiceRepeatMode = AudioServiceRepeatMode.all;
  int _currentIndex = 0;
  int _consecutivePlayFailures = 0;
  int _preloadToken = 0;
  bool _nextInFlight = false;
  bool _previousInFlight = false;

  PreparedSongUrl? _nextPrepared;
  PreparedSongUrl? _previousPrepared;

  MusicHandler() {
    _loadPlayListByStorage();
    _listenToPlaybackState();
    _listenToSequenceState();
  }

  void _clearPreparedUrls() {
    _dropInFlightPreloads();
    _nextPrepared = null;
    _previousPrepared = null;
  }

  /// 丢掉还没返回的预加载，但保留已经对上歌曲 id 的结果，切歌时还能用。
  void _dropInFlightPreloads() {
    _preloadToken++;
    _nextInFlight = false;
    _previousInFlight = false;
  }

  void _listenToPlaybackState() {
    _subscriptions.add(_audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _audioPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          PlatformUtils.isAndroid
              ? ((mediaItem.value?.extras?['liked'] ?? false)
                  ? const MediaControl(
                      label: 'fastForward',
                      action: MediaAction.fastForward,
                      androidIcon: 'drawable/audio_service_like')
                  : const MediaControl(
                      label: 'rewind',
                      action: MediaAction.rewind,
                      androidIcon: 'drawable/audio_service_unlike'))
              : const MediaControl(
                  label: 'setRating',
                  action: MediaAction.setRating,
                  androidIcon: 'drawable/audio_service_like'),
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [1, 2, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_audioPlayer.processingState]!,
        repeatMode: _audioServiceRepeatMode,
        shuffleMode: (_audioPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
        queueIndex: _currentIndex,
      ));
    }));
  }

  void _listenToSequenceState() {
    _subscriptions.add(_audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        skipToNext();
      }
    }));
  }

  Future<void> _loadPlayListByStorage() async {
    String repeatMode = _box.get(REPEAT_MODE, defaultValue: "all");
    _audioServiceRepeatMode = AudioServiceRepeatMode.values
            .firstWhereOrNull((element) => element.name == repeatMode) ??
        AudioServiceRepeatMode.all;
    _currentIndex = _box.get(PLAY_INDEX, defaultValue: 0);
    List<String> playList = _box.get(PLAY_QUEUE, defaultValue: []);
    if (playList.isNotEmpty) {
      List<MediaItem> items = await compute(getCachePlayList,
          RootIsolateData(rootIsolateToken, playList: playList));
      if (items.isEmpty) return;
      if (_currentIndex < 0 || _currentIndex >= items.length) {
        _currentIndex = 0;
      }
      await changeQueueLists(items, init: true, index: _currentIndex);
    }
  }

  Future<void> setUrl(String url) async {
    await _audioPlayer.setUrl(url);
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {}

  @override
  Future<void> removeQueueItemAt(int index) async {
    final currentQueue = List<MediaItem>.from(queue.value);
    if (index < 0 || index >= currentQueue.length) return;
    if (index == _currentIndex) {
      WidgetUtil.showToast('当前歌曲正在播放，无法删除');
      return;
    }

    final removed = currentQueue.removeAt(index);
    _playList.remove(removed);
    _playListShut.remove(removed);
    if (index < _currentIndex) {
      _currentIndex--;
    }
    _box.put(PLAY_INDEX, _currentIndex);
    _clearPreparedUrls();
    queue.add(currentQueue);
    final cached = await compute(
      setCachePlayList,
      RootIsolateData(rootIsolateToken, items: _playList),
    );
    _box.put(PLAY_QUEUE, cached);
  }

  // 通知栏按钮目前映射到喜欢/取消喜欢，接口尚未接入。
  @override
  Future<void> fastForward() async {}

  @override
  Future<void> rewind() async {}

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> changeQueueLists(List<MediaItem> list,
      {int index = 0, bool init = false}) async {
    _clearPreparedUrls();
    if (list.isEmpty) {
      _playList.clear();
      _playListShut.clear();
      _currentIndex = 0;
      await updateQueue(const []);
      return;
    }
    if (!init &&
        Get.isRegistered<RoamingController>() &&
        RoamingController.to.fm.value) {
      RoamingController.to.fm.value = false;
      _box.put(FM_SP, false);
    }
    if (index < 0 || index >= list.length) index = 0;
    _currentIndex = index;
    _playList
      ..clear()
      ..addAll(list);
    final isShuffle = _box.get(REPEAT_MODE, defaultValue: 'all') ==
        AudioServiceRepeatMode.none.name;
    if (isShuffle) {
      _playListShut
        ..clear()
        ..addAll(list)
        ..shuffle();
      await updateQueue(_playListShut);
      var songId = list[index].id;
      if (init) songId = _box.get(PLAY_ID, defaultValue: songId);
      final indexBy = _playListShut.indexWhere((element) => element.id == songId);
      if (indexBy != -1) {
        _currentIndex = indexBy;
      }
    } else {
      _playListShut.clear();
      await updateQueue(_playList);
    }
    await playIndex(_currentIndex, playIt: !init);
    if (!init) {
      final playList = await compute(
        setCachePlayList,
        RootIsolateData(rootIsolateToken, items: _playList),
      );
      _box.put(PLAY_QUEUE, playList);
    }
  }

  @override
  Future<void> playIndex(int index, {bool playIt = true}) async {
    if (queue.value.isEmpty) return;
    if (index < 0 || index >= queue.value.length) return;
    _currentIndex = index;
    _box.put(PLAY_INDEX, _currentIndex);
    _clearPreparedUrls();
    await readySongUrl(playIt: playIt);
  }

  Future<String?> _preloadSongUrl(MediaItem song) async {
    if (song.extras?["type"] == MediaType.local.name ||
        song.extras?['type'] == MediaType.neteaseCache.name) {
      final localUrl = song.extras?['url'];
      if (localUrl is String && localUrl.isNotEmpty) return localUrl;
      return null;
    }

    try {
      final songUrl = await RoamingApi.getSongInfo([song.id]);
      final songs = songUrl.data ?? [];
      if (songs.isEmpty) return null;
      final raw = songs.first.url ?? '';
      if (raw.isEmpty) return null;
      return raw.split('?').first;
    } catch (e) {
      LogBox.error(e, msg: '获取歌曲地址失败');
      return null;
    }
  }

  Future<void> _preloadAt({required bool next}) async {
    if (queue.value.length < 2) return;
    if (next) {
      if (_nextPrepared != null || _nextInFlight) return;
      _nextInFlight = true;
    } else {
      if (_previousPrepared != null || _previousInFlight) return;
      _previousInFlight = true;
    }

    final token = _preloadToken;
    final index = movePlaylistIndex(
      _currentIndex,
      queue.value.length,
      next: next,
      repeatOne: false,
    );
    if (index == _currentIndex || index < 0 || index >= queue.value.length) {
      if (next) {
        _nextInFlight = false;
      } else {
        _previousInFlight = false;
      }
      return;
    }

    final song = queue.value[index];
    final url = await _preloadSongUrl(song);
    if (token != _preloadToken) return;
    if (next) {
      _nextInFlight = false;
      if (url != null) _nextPrepared = PreparedSongUrl(song.id, url);
    } else {
      _previousInFlight = false;
      if (url != null) _previousPrepared = PreparedSongUrl(song.id, url);
    }
  }

  @override
  Future<void> readySongUrl({bool isNext = true, bool playIt = true}) async {
    try {
      if (queue.value.isEmpty) return;
      if (_currentIndex < 0 || _currentIndex >= queue.value.length) {
        _currentIndex = wrapPlaylistIndex(_currentIndex, queue.value.length);
      }
      final song = queue.value[_currentIndex];
      mediaItem.add(song);
      _box.put(PLAY_ID, song.id);

      final prepared = isNext ? _nextPrepared : _previousPrepared;
      if (isNext) {
        _nextPrepared = null;
      } else {
        _previousPrepared = null;
      }
      final url = takePreparedUrl(prepared, song.id) ?? await _preloadSongUrl(song);
      if (url == null || url.isEmpty) {
        throw StateError('歌曲地址为空');
      }

      await _audioPlayer.setUrl(
        url,
        initialPosition: Duration.zero,
        preload: true,
      );

      if (playIt) {
        await _audioPlayer.play();
      }
      _consecutivePlayFailures = 0;
      unawaited(_preloadAt(next: true));
      unawaited(_preloadAt(next: false));
    } catch (e) {
      LogBox.error(e, msg: '播放失败');
      _consecutivePlayFailures++;
      final total = queue.value.length;
      if (total == 0 || _consecutivePlayFailures >= total) {
        _consecutivePlayFailures = 0;
        WidgetUtil.showToast('播放失败，请检查网络');
        return;
      }
      if (isNext) {
        await skipToNext();
      } else {
        await skipToPrevious();
      }
    }
  }

  void _setCurIndex({bool next = false}) {
    final list = _audioServiceRepeatMode == AudioServiceRepeatMode.none
        ? _playListShut
        : _playList;
    _currentIndex = movePlaylistIndex(
      _currentIndex,
      list.isEmpty ? queue.value.length : list.length,
      next: next,
      repeatOne: _audioServiceRepeatMode == AudioServiceRepeatMode.one,
    );
    _box.put(PLAY_INDEX, _currentIndex);
  }

  @override
  Future<void> skipToNext() async {
    _dropInFlightPreloads();
    _setCurIndex(next: true);
    LogBox.info('下一首$_currentIndex');
    await readySongUrl();
    if (Get.isRegistered<RoamingController>() &&
        RoamingController.to.fm.value &&
        queue.value.isNotEmpty &&
        _currentIndex == queue.value.length - 1 &&
        Get.isRegistered<MainController>()) {
      MainController.to.getPersonalizedDjProgram();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    await stop();
    _dropInFlightPreloads();
    _setCurIndex();
    await readySongUrl(isNext: false);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    _audioServiceRepeatMode = repeatMode;
    _box.put(REPEAT_MODE, repeatMode.name);
    if (queue.value.isEmpty || _playList.isEmpty) return;
    final safeIndex = _currentIndex >= 0 && _currentIndex < queue.value.length
        ? _currentIndex
        : 0;
    final current = queue.value[safeIndex];
    _clearPreparedUrls();
    if (repeatMode == AudioServiceRepeatMode.none) {
      _playListShut
        ..clear()
        ..addAll(_playList)
        ..shuffle();
      final index = _playListShut.indexWhere((element) => element.id == current.id);
      if (index != -1) _currentIndex = index;
      await updateQueue(_playListShut);
    } else {
      final index = _playList.indexWhere((element) => element.id == current.id);
      if (index != -1) _currentIndex = index;
      _playListShut.clear();
      await updateQueue(_playList);
    }
    _box.put(PLAY_INDEX, _currentIndex);
  }

  @override
  Future<void> onTaskRemoved() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    _clearPreparedUrls();
    await stop();
    await _audioPlayer.dispose();
  }

  @override
  Future<void> addFmItems(
      List<MediaItem> mediaItems, bool isAddcurIndex) async {
    _clearPreparedUrls();
    if (Get.isRegistered<RoamingController>() &&
        RoamingController.to.fm.value &&
        _playList.length >= 3) {
      _playList.removeRange(0, 3);
      updateQueue(_playList);
      addQueueItems(mediaItems);
    } else {
      _playList.clear();
      updateQueue(mediaItems);
      _box.put(FM_SP, true);
    }
    _currentIndex = 0;
    _playList.addAll(mediaItems);
    if (isAddcurIndex) _currentIndex++;
    if (Get.isRegistered<RoamingController>() &&
        !RoamingController.to.fm.value) {
      RoamingController.to.fm.value = true;
    }
    playIndex(_currentIndex);
    List<String> playList = await compute(
        setCachePlayList, RootIsolateData(rootIsolateToken, items: _playList));
    queueTitle.value = 'FM';
    _box.put(PLAY_QUEUE, playList);
  }
}

class MediaItemMessage {
  final String id;

  final String title;

  final String? album;

  final String? artist;

  final String? genre;

  final Duration? duration;

  final Uri? artUri;

  final bool? playable;

  final String? displayTitle;

  final String? displaySubtitle;

  final String? displayDescription;

  final Map<String, dynamic>? extras;

  MediaItemMessage(
      {required this.id,
      required this.title,
      this.album,
      this.artist,
      this.genre,
      this.duration,
      this.artUri,
      this.playable,
      this.displayTitle,
      this.displaySubtitle,
      this.displayDescription,
      this.extras});

  factory MediaItemMessage.fromMap(Map<String, dynamic> raw) =>
      MediaItemMessage(
        id: raw['id'] as String,
        title: raw['title'] as String,
        album: raw['album'] as String?,
        artist: raw['artist'] as String?,
        genre: raw['genre'] as String?,
        duration: raw['duration'] != null
            ? Duration(milliseconds: raw['duration'] as int)
            : null,
        artUri:
            raw['artUri'] != null ? Uri.parse(raw['artUri'] as String) : null,
        playable: raw['playable'] as bool?,
        displayTitle: raw['displayTitle'] as String?,
        displaySubtitle: raw['displaySubtitle'] as String?,
        displayDescription: raw['displayDescription'] as String?,
        extras: castMap(raw['extras'] as Map?),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'album': album,
        'artist': artist,
        'genre': genre,
        'duration': duration?.inMilliseconds,
        'artUri': artUri?.toString(),
        'playable': playable,
        'displayTitle': displayTitle,
        'displaySubtitle': displaySubtitle,
        'displayDescription': displayDescription,
        'extras': extras,
      };
}

Map<String, dynamic>? castMap(Map? map) {
  if (map == null) return null;
  return map.cast<String, dynamic>();
}

enum MediaType { local, playlist, fm, radio, neteaseCache }

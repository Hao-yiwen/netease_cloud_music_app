import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/banner.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/home_block.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/mv_list.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../../http/api/found/found_api.dart';
import '../../http/api/main/dto/song_dto.dart';
import 'item_type.dart';

class FoundController extends GetxController {
  // loading
  RxBool loading = false.obs;

  // banner
  Rx<Banner> banner = Banner().obs;
  Rx<HomeBlock> homeBlock = HomeBlock().obs;

  // slide song list align
  RxList<MediaItem> slideSongListAlign = <MediaItem>[].obs;

  // 新歌 新碟 数字专辑
  RxList<MediaItem> newAlbum = <MediaItem>[].obs;
  RxList<MediaItem> newSong = <MediaItem>[].obs;
  RxList<MediaItem> digitalAlbums = <MediaItem>[].obs;

  // 全部mv
  Rx<MvList> mvList = MvList().obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    loading.value = true;

    try {
      await Future.wait(<Future>[
        _getBanner().catchError((e) {
          LogBox.error('Banner error: $e');
          return null;
        }),
        _getHomeBlock().catchError((e) {
          LogBox.error('HomeBlock error: $e');
          return null;
        }),
        _getMvList().catchError((e) {
          LogBox.error('MV list error: $e');
          return null;
        }),
      ]);
    } finally {
      loading.value = false;
    }
  }

  refreshHome() async {
    await _getHomeBlock(isRefresh: true);
    update(); // 强制更新UI
  }

  refreshMv() async {
    await _getMvList();
    update(); // 强制更新UI
  }

  _getBanner() async {
    try {
      if (Platform.isIOS) {
        banner.value = await FoundApi.getBanner(BannerType.IPHONE.value);
      } else {
        banner.value = await FoundApi.getBanner(BannerType.ANDROID.value);
      }
    } catch (e) {
      LogBox.error(e);
    }
  }

  Future<void> _getMvList() async {
    try {
      mvList.value = await FoundApi.getAllMvList();
    } catch (e) {
      LogBox.error(e);
    }
  }

  static FoundController get to => Get.find<FoundController>();

  Future<void> _getHomeBlock({bool isRefresh = false}) async {
    try {
      homeBlock.value = await FoundApi.getHomeBlock(isRefresh: isRefresh);

      // HOMEPAGE_SLIDE_SONGLIST_ALIGN获取mediaItem列表
      await _buildSlideSongListAlign();

      // HOMEPAGE_NEW_SONG_NEW_ALBUM获取mediaItem列表
      await _buildNewSongNewAlbum();

      // 强制更新UI
      update();
    } catch (e) {
      LogBox.error(e);
    }
  }

  Future<List<MediaItem>> getSongDetail(String ids) async {
    try {
      SongsDetailDto list = await MainApi.getSongsDetail(ids);
      if (list?.songs?.isNotEmpty ?? false) {
        return RoamingController.to.song2ToMedia(list.songs!);
      }
    } catch (e) {
      LogBox.error('获取歌曲详情失败: $e');
    }
    return [];
  }

  Future<void> _buildSlideSongListAlign() async {
    if (homeBlock.value.blocks == null) return;

    try {
      final ids = homeBlock.value.blocks!
          .where((block) =>
              block.showType ==
              ItemTypeEnum.HOMEPAGE_SLIDE_SONGLIST_ALIGN.value)
          .expand((block) => block.creatives ?? [])
          .expand((list) => list.resources ?? [])
          .where((el) => el.resourceType == "song")
          .map((el) => el.resourceId.toString())
          .toList();

      if (ids.isEmpty) return;

      final songs = await getSongDetail(ids.join(','));
      if (songs.isNotEmpty) {
        slideSongListAlign.value = songs;
        update(); // 强制更新UI
      }
    } catch (e) {
      LogBox.error('构建滑动歌单失败: $e');
    }
  }

  Future<void> _buildNewSongNewAlbum() async {
    if (homeBlock.value.blocks == null) return;

    try {
      final resourceMap = _extractResourceIds();

      await Future.wait([
        if (resourceMap['songs']!.isNotEmpty)
          getSongDetail(resourceMap['songs']!.join(',')).then((value) {
            if (value.isNotEmpty) {
              newSong.value = value;
            }
          }).catchError((e) => LogBox.error('新歌加载失败: $e')),
        if (resourceMap['albums']!.isNotEmpty)
          getSongDetail(resourceMap['albums']!.join(',')).then((value) {
            if (value.isNotEmpty) {
              newAlbum.value = value;
            }
          }).catchError((e) => LogBox.error('新碟加载失败: $e')),
        if (resourceMap['digitalAlbums']!.isNotEmpty)
          getSongDetail(resourceMap['digitalAlbums']!.join(',')).then((value) {
            if (value.isNotEmpty) {
              digitalAlbums.value = value;
            }
          }).catchError((e) => LogBox.error('数字专辑加载失败: $e')),
      ]);

      update(); // 强制更新UI
    } catch (e) {
      LogBox.error('构建新歌新碟失败: $e');
    }
  }

  Map<String, List<String>> _extractResourceIds() {
    final songIds = <String>[];
    final albumIds = <String>[];
    final digitalAlbumsIds = <String>[];

    final newSongAlbumBlocks = homeBlock.value.blocks!.where((block) =>
        block.showType == ItemTypeEnum.HOMEPAGE_NEW_SONG_NEW_ALBUM.value);

    for (final block in newSongAlbumBlocks) {
      _processCreatives(
          block.creatives, AlbumTypeEnum.NEW_SONG_HOMEPAGE.value, songIds);
      _processCreatives(
          block.creatives, AlbumTypeEnum.NEW_ALBUM_HOMEPAGE.value, albumIds);
      _processCreatives(block.creatives,
          AlbumTypeEnum.DIGITAL_ALBUM_HOMEPAGE.value, digitalAlbumsIds);
    }

    return {
      'songs': songIds,
      'albums': albumIds,
      'digitalAlbums': digitalAlbumsIds,
    };
  }

  void _processCreatives(
      List<Creative>? creatives, String type, List<String> ids) {
    creatives
        ?.where((el) => el.creativeType == type)
        .expand((list) => list.resources ?? [])
        .where((el) => el.resourceType == "album" || el.resourceType == "song")
        .forEach((el) => ids.add(el.resourceId.toString()));
  }
}

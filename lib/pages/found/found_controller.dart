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
    _getBanner();
    _getHomeBlock();
    _getMvList();
  }

  refreshHome() {
    _getHomeBlock(isRefresh: true);
  }

  refreshMv() {
    _getMvList();
  }

  _getBanner() async {
    try {
      loading.value = true;
      if (Platform.isIOS) {
        banner.value = await FoundApi.getBanner(BannerType.IPHONE.value);
      } else {
        banner.value = await FoundApi.getBanner(BannerType.ANDROID.value);
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  Future<void> _getMvList() async {
    try {
      loading.value = true;
      mvList.value = await FoundApi.getAllMvList();
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  static FoundController get to => Get.find<FoundController>();

  _getHomeBlock({bool isRefresh = false}) async {
    try {
      loading.value = true;
      homeBlock.value = await FoundApi.getHomeBlock(isRefresh: isRefresh);

      // HOMEPAGE_SLIDE_SONGLIST_ALIGN获取mediaItem列表
      await _buildSlideSongListAlign();

      // HOMEPAGE_NEW_SONG_NEW_ALBUM获取mediaItem列表
      await _buildNewSongNewAlbum();
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  Future<List<MediaItem>> getSongDetail(String ids) async {
    SongsDetailDto list = await MainApi.getSongsDetail(ids);
    if (list?.songs?.isNotEmpty ?? false) {
      return RoamingController.to.song2ToMedia(list.songs!);
    }
    return [];
  }

  Future<void> _buildSlideSongListAlign() async {
    List<String> ids = [];
    homeBlock.value.blocks?.forEach((block) {
      if (block.showType == ItemTypeEnum.HOMEPAGE_SLIDE_SONGLIST_ALIGN.value) {
        block.creatives?.forEach((list) {
          list.resources?.forEach((el) {
            if (el.resourceType == "song") {
              ids.add(el.resourceId.toString());
            }
          });
        });
      }
    });
    slideSongListAlign.value = await getSongDetail(ids.join(','));
  }

  _buildNewSongNewAlbum() async {
    List<String> songIds = [];
    List<String> albumIds = [];
    List<String> digitalAlbumsIds = [];
    homeBlock.value.blocks?.forEach((block) {
      if (block.showType == ItemTypeEnum.HOMEPAGE_NEW_SONG_NEW_ALBUM.value) {
        List<Creative> newSongs = block.creatives!
            .where((el) =>
                el.creativeType == AlbumTypeEnum.NEW_SONG_HOMEPAGE.value)
            .toList();
        List<Creative> newAlbums = block.creatives!
            .where((el) =>
                el.creativeType == AlbumTypeEnum.NEW_ALBUM_HOMEPAGE.value)
            .toList();
        List<Creative> digitalAlbums = block.creatives!
            .where((el) =>
                el.creativeType == AlbumTypeEnum.DIGITAL_ALBUM_HOMEPAGE.value)
            .toList();
        newSongs?.forEach((list) {
          list.resources?.forEach((el) {
            if (el.resourceType == "song") {
              songIds.add(el.resourceId.toString());
            }
          });
        });
        newAlbums?.forEach((list) {
          list.resources?.forEach((el) {
            if (el.resourceType == "album") {
              albumIds.add(el.resourceId.toString());
            }
          });
        });
        digitalAlbums?.forEach((list) {
          list.resources?.forEach((el) {
            if (el.resourceType == "album") {
              digitalAlbumsIds.add(el.resourceId.toString());
            }
          });
        });
      }
    });
    if (songIds.isNotEmpty)
      newSong.value = await getSongDetail(songIds.join(','));
    if (albumIds.isNotEmpty)
      newAlbum.value = await getSongDetail(albumIds.join(','));
    if (digitalAlbumsIds.isNotEmpty)
      digitalAlbums.value = await getSongDetail(digitalAlbumsIds.join(','));
  }
}

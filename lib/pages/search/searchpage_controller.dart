import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_keys.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_mvs.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_result.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_songlist.dart';
import 'package:netease_cloud_music_app/http/api/search/search_api.dart';

import '../../http/api/main/dto/song_dto.dart';
import '../../http/api/main/main_api.dart';
import '../roaming/roaming_controller.dart';

class SearchpageController extends GetxController {
  final box = GetIt.instance<Box>();
  RxBool searchDetailLoading = false.obs;
  Rx<SearchResult> searchResult = SearchResult().obs;
  Rx<SearchMvs> searchMvs = SearchMvs().obs;
  Rx<SearchSonglist> songList = SearchSonglist().obs;
  Rx<SearchKeys> keyWordsSuggest = SearchKeys().obs;
  RxString textvalue = ''.obs;
  RxList<String> searchKey = <String>[].obs;

  // 私人fm推荐音乐
  Rx<List<MediaItem>> searchSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  Future<void> searchKeyWords(String keyWords) async {
    try {
      searchDetailLoading.value = true;
      searchResult.value = await SearchApi.search(keyWords);
      // 获取音乐单曲播放信息
      if (searchResult.value != null &&
          (searchResult.value.result?.songs?.isNotEmpty ?? false)) {
        String ids = "";
        for (int i = 0; i < searchResult.value.result!.songs!.length; i++) {
          if (searchResult.value.result!.songs![i].id != null) {
            ids += searchResult.value.result!.songs![i].id.toString();
            if (i != searchResult.value.result!.songs!.length - 1) {
              ids += ",";
            }
          }
        }
        SongsDetailDto songsDetailDto = await MainApi.getSongsDetail(ids);
        if (songsDetailDto.songs?.isNotEmpty ?? false) {
          searchSongs.value =
              RoamingController.to.song2ToMedia(songsDetailDto.songs!);
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      searchDetailLoading.value = false;
    }
  }

  Future<void> searchMv(String keyWords) async {
    try {
      searchDetailLoading.value = true;
      searchMvs.value = await SearchApi.searchMvs(keyWords, type: '1004');
    } catch (e) {
      LogBox.error(e);
    } finally {
      searchDetailLoading.value = false;
    }
  }

  Future<void> searchSongList(String keyWords) async {
    try {
      searchDetailLoading.value = true;
      songList.value = await SearchApi.searchSongList(keyWords, type: '1000');
    } catch (e) {
      LogBox.error(e);
    } finally {
      searchDetailLoading.value = false;
    }
  }

  Future<void> searchSuggest(String keyWords) async {
    try {
      searchDetailLoading.value = true;
      keyWordsSuggest.value = await SearchApi.searchSuggest(keyWords);
    } catch (e) {
      LogBox.error(e);
    } finally {
      searchDetailLoading.value = false;
    }
  }

  void saveSearchKeyWords(String keyWords) {
    if (keyWords.isEmpty) {
      WidgetUtil.showToast('搜索关键词不能为空');
      return;
    }
    const key = 'searchKeyWords';
    var searchKeyWords = box.get(key, defaultValue: <String>[]);
    var result =
        searchKeyWords.where((element) => element != keyWords).toList();
    result.insert(0, keyWords);
    box.put(key, result);
    getSearchKeyWords();
  }

  void getSearchKeyWords() {
    const key = 'searchKeyWords';
    searchKey.value = box.get(key, defaultValue: <String>[]);
  }

  void deleteSearchKeyWords(String keyWords) {
    const key = 'searchKeyWords';
    var searchKeyWords = box.get(key, defaultValue: <String>[]);
    var result =
        searchKeyWords.where((element) => element != keyWords).toList();
    box.put(key, result);
    searchKey.value = result;
  }

  void clearData() {
    searchResult.value = SearchResult(); // 清除单曲数据
    searchMvs.value = SearchMvs(); // 清除视频数据
  }

  void clearSearchKeyWords() {
    const key = 'searchKeyWords';
    box.delete(key);
    getSearchKeyWords();
  }
}

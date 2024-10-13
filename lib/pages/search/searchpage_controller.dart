import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_result.dart';
import 'package:netease_cloud_music_app/http/api/search/search_api.dart';

import '../../http/api/main/dto/song_dto.dart';
import '../../http/api/main/main_api.dart';
import '../roaming/roaming_controller.dart';

class SearchpageController extends GetxController {
  RxBool searchDetailLoading = false.obs;
  Rx<SearchResult> searchResult = SearchResult().obs;
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
      // searchResult.value = await SearchApi.search(keyWords, type: '1004');
    } catch (e) {
      LogBox.error(e);
    } finally {
      searchDetailLoading.value = false;
    }
  }
}

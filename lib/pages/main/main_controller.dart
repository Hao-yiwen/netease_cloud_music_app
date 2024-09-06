import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/song_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;
  Rx<RecommendResourceDto> recommendResourceDto = RecommendResourceDto().obs;
  Rx<List<SongDto>> privateRadarSongs = Rx<List<SongDto>>(<SongDto>[]);

  @override
  void onReady() {
    super.onReady();
    _getPrivateRadar();
    _getRecommandSongs();
  }

  _getRecommandSongs() async {
    try {
      loading.value = true;
      recommendSongsDto?.value = await MainApi.getRecommendSongs();
    } catch (e) {
      LogBox.error(e.toString());
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
        if (playlistDetail.playlist?.tracks != null) {
          privateRadarSongs.value = playlistDetail.playlist!.tracks!;
        }
      }
    } catch (e) {
      LogBox.error(e.toString());
    } finally {
      loading.value = false;
    }
  }
}

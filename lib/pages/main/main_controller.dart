import 'package:get/get.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;

  @override
  void onReady() {
    super.onReady();
    _getRecommandSongs();
  }

  _getRecommandSongs() async {
    try {
      loading.value = true;
      recommendSongsDto?.value = await MainApi.getRecommendSongs();
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }

  _getPrivateRadar() async {
    // 首先先从推荐资源拿到私人雷达的歌单id
    // 通过歌单id获取歌曲详细信息
  }
}

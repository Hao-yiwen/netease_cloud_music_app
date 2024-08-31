import 'package:get/get.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/main_api.dart';

class MainController extends GetxController {
  RxBool loading = true.obs;
  Rx<RecommendSongsDto> recommendSongsDto = RecommendSongsDto().obs;

  @override
  void onReady() {
    super.onReady();
    _getRecommandSongs();
    loading.value = false;
  }

  _getRecommandSongs() async {
    try {
      recommendSongsDto?.value = await MainApi.getRecommendSongs();
    } catch (e) {
      print(e);
    }
  }
}

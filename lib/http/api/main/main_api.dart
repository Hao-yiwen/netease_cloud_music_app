import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';

import '../../http.dart';
import '../../http_utils.dart';
import '../login/dto/login_status_dto.dart';

class MainApi {
  static Future<RecommendSongsDto> getRecommendSongs() async {
    final res = await HttpUtils.get('/recommend/songs');
    return RecommendSongsDto.fromJson(res["data"]);
  }
}

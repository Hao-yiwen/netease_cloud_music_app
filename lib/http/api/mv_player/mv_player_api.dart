import 'package:netease_cloud_music_app/http/api/mv_player/dto/mv_detail.dart';

import '../../http_utils.dart';

class MvPlayerApi {
  static Future<MvDetail> getMvDetail(int id) async {
    final res = await HttpUtils.get("/mv/url?id=$id");
    return MvDetail.fromJson(res);
  }
}

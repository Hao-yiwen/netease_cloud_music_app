import 'package:netease_cloud_music_app/http/api/found/dto/banner.dart';

import '../../http_utils.dart';

class FoundApi {
  static Future<Banner> getBanner(int type) async {
    final res = await HttpUtils.get('/banner', params: {
      "type": type,
    });
    return Banner.fromJson(res);
  }
}

enum BannerType {
  PC(0),
  ANDROID(1),
  IPHONE(2),
  IPAD(3);

  final int value;

  const BannerType(this.value);
}

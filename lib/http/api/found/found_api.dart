import 'package:netease_cloud_music_app/http/api/found/dto/banner.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/home_block.dart';

import '../../http_utils.dart';

class FoundApi {
  static Future<Banner> getBanner(int type) async {
    final res = await HttpUtils.get('/banner', params: {
      "type": type,
    });
    return Banner.fromJson(res);
  }

  static Future<HomeBlock> getHomeBlock() async {
    final res = await HttpUtils.get('/homepage/block/page');
    if (res.data != null) {
      return HomeBlock.fromJson(res.data);
    } else {
      throw Exception('Failed to load home block');
    }
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

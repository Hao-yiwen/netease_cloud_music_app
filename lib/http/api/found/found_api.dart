import 'package:netease_cloud_music_app/http/api/found/dto/banner.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/home_block.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/mv_list.dart';

import '../../http_utils.dart';

class FoundApi {
  static Future<Banner> getBanner(int type) async {
    final res = await HttpUtils.get('/banner', params: {
      "type": type,
    });
    return Banner.fromJson(res);
  }

  static Future<HomeBlock> getHomeBlock({bool isRefresh = false}) async {
    final res = await HttpUtils.get('/homepage/block/page', params: {
      "refresh": isRefresh,
    });
    if (res["data"] != null) {
      return HomeBlock.fromJson(res["data"]);
    } else {
      throw Exception('Failed to load home block');
    }
  }

  static Future<MvList> getAllMvList() async {
    final res = await HttpUtils.get('/mv/all', params: {
      "limit": 30,
    });
    return MvList.fromJson(res);
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

import 'package:netease_cloud_music_app/http/api/search/dto/search_result.dart';

import '../../http_utils.dart';

class SearchApi {
  static Future<SearchResult> search(String query, {
    String type = '1',
  }) async {
    final res = await HttpUtils.get('/search', params: {
      'keywords': query,
      'type': type,
    });
    return SearchResult.fromJson(res);
  }
}
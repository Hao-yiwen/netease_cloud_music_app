import 'package:netease_cloud_music_app/http/api/search/dto/search_keys.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_mvs.dart';
import 'package:netease_cloud_music_app/http/api/search/dto/search_result.dart';

import '../../http_utils.dart';
import 'dto/search_songlist.dart';

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

  static Future<SearchMvs> searchMvs(String query, {
    String type = '1004',
  }) async {
    final res = await HttpUtils.get('/search', params: {
      'keywords': query,
      'type': type,
    });
    return SearchMvs.fromJson(res);
  }

  static Future<SearchSonglist> searchSongList(String query, {
    String type = '1000',
  }) async {
    final res = await HttpUtils.get('/search', params: {
      'keywords': query,
      'type': type,
    });
    return SearchSonglist.fromJson(res);
  }

  static Future<SearchKeys> searchSuggest(String query, {
    String type = 'mobile',
  }) async {
    final res = await HttpUtils.get('/search/suggest', params: {
      'keywords': query,
      'type': type,
    });
    return SearchKeys.fromJson(res);
  }
}
import 'package:netease_cloud_music_app/http/api/roaming/dto/comment_music.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_info_dto.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_lyric.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';

class RoamingApi {
  // 获取歌曲信息 主要给首页页面使用
  static Future<SongInfoListDto> getSongInfo(dynamic id) async {
    if (id is List) {
      id = id.join(',');
    }
    final res = await HttpUtils.get('/song/url/v1', params: {
      'id': id,
      'level': 'exhigh',
    });
    return SongInfoListDto.fromJson(res);
  }

  // 获取音乐评论
  static Future<CommentMusic> getMusicComment(dynamic? id,
      {int limit = 20, int offset = 0}) async {
    final res = await HttpUtils.get('/comment/music', params: {
      'id': (id is String) ? id : id.toString(),
      'limit': limit,
      'offset': offset,
    });
    return CommentMusic.fromJson(res);
  }

  // 获取歌词
  static Future<SongLyric> getMusicLyric(dynamic id) async {
    final res = await HttpUtils.get('/lyric', params: {
      'id': id,
    });
    return SongLyric.fromJson(res);
  }
}

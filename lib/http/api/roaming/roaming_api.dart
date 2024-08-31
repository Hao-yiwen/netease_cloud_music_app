import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_info_dto.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';

class RoamingApi {
  static Future<SongInfoListDto> getSongInfo(int id) async {
    final res = await HttpUtils.get('/song/url/v1', params: {
      'id': id,
      'level': 'exhigh',
    });
    return SongInfoListDto.fromJson(res);
  }
}

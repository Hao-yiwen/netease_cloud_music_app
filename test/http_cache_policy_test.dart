import 'package:flutter_test/flutter_test.dart';
import 'package:netease_cloud_music_app/http/cache_policy.dart';

void main() {
  test('public catalogue requests can be cached', () {
    expect(
      resolveHttpCacheMode('/banner', refresh: false),
      HttpCacheMode.cache,
    );
    expect(
      resolveHttpCacheMode('/playlist/detail/', refresh: true),
      HttpCacheMode.refresh,
    );
  });

  test('login, user data and song urls are never cached', () {
    for (final path in [
      '/login/cellphone',
      '/captcha/sent',
      '/login/status',
      '/likelist',
      '/personal_fm',
      '/song/url/v1',
      '/user/playlist',
      '/recommend/songs',
    ]) {
      expect(resolveHttpCacheMode(path, refresh: false), HttpCacheMode.none,
          reason: path);
      expect(resolveHttpCacheMode(path, refresh: true), HttpCacheMode.none,
          reason: path);
    }
  });
}

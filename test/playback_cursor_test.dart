import 'package:flutter_test/flutter_test.dart';
import 'package:netease_cloud_music_app/common/playback_cursor.dart';

void main() {
  test('wraps negative and overflow indexes', () {
    expect(wrapPlaylistIndex(-1, 4), 3);
    expect(wrapPlaylistIndex(4, 4), 0);
    expect(wrapPlaylistIndex(0, 0), 0);
  });

  test('repeat-one does not move', () {
    expect(
      movePlaylistIndex(2, 5, next: true, repeatOne: true),
      2,
    );
    expect(
      movePlaylistIndex(0, 5, next: false, repeatOne: false),
      4,
    );
  });

  test('prepared url is used only for the matching song', () {
    const prepared = PreparedSongUrl('12', 'https://cdn/a.mp3');
    expect(takePreparedUrl(prepared, '12'), 'https://cdn/a.mp3');
    expect(takePreparedUrl(prepared, '13'), isNull);
    expect(takePreparedUrl(const PreparedSongUrl('12', '  '), '12'), isNull);
  });
}

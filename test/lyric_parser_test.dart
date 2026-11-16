import 'package:flutter_test/flutter_test.dart';
import 'package:netease_cloud_music_app/common/lyric_parser/parser_lrc.dart';

void main() {
  test('two-digit LRC time is centiseconds', () {
    final lines = ParserLrc('[00:03.47]你好').parseLines();
    expect(lines, hasLength(1));
    expect(lines.first.startTime, 3470);
    expect(lines.first.mainText, '你好');
  });

  test('three-digit LRC time is milliseconds', () {
    final lines = ParserLrc('[01:02.345]line').parseLines();
    expect(lines.single.startTime, 62345);
  });

  test('one line with multiple timestamps becomes multiple lyric lines', () {
    final lines = ParserLrc('[00:01.00][00:03.50]重复句').parseLines();
    expect(lines.map((line) => line.startTime).toList(), [1000, 3500]);
    expect(lines.every((line) => line.mainText == '重复句'), isTrue);
  });

  test('metadata and empty marker are ignored or cleared', () {
    final lines = ParserLrc('[ti:歌名]\n[00:01.00]//\r\n[00:02.00]第二行\n')
        .parseLines();
    expect(lines, hasLength(2));
    expect(lines.first.mainText, '');
    expect(lines.last.mainText, '第二行');
  });

  test('translation text is stored separately', () {
    final lines = ParserLrc('[00:01.00]hello').parseLines(isMain: false);
    expect(lines.single.mainText, isNull);
    expect(lines.single.extText, 'hello');
  });
}

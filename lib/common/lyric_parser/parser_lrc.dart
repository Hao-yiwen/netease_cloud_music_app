import 'package:netease_cloud_music_app/common/lyric_parser/LyricsLineModel.dart';
import 'package:netease_cloud_music_app/common/lyric_parser/lyrics_parse.dart';

class ParserLrc extends LyricParse {
  /// `[mm:ss.xx]` 或 `[mm:ss.xxx]`。小数点必须是点，不能匹配任意字符。
  static final RegExp timeTagPattern =
      RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\]');

  ParserLrc(super.lyric);

  @override
  List<LyricsLineModel> parseLines({bool isMain = true}) {
    final lineList = <LyricsLineModel>[];
    for (final rawLine in lyric.split(RegExp(r'\r?\n'))) {
      final matches = timeTagPattern.allMatches(rawLine).toList();
      if (matches.isEmpty) continue;

      var text = rawLine.replaceAll(timeTagPattern, '').replaceAll('\n', '');
      if (text == '//') text = '';

      for (final match in matches) {
        final ts = timestampMatchToMs(match);
        if (ts == null) continue;
        final lineModel = LyricsLineModel()..startTime = ts;
        if (isMain) {
          lineModel.mainText = text;
        } else {
          lineModel.extText = text;
        }
        lineList.add(lineModel);
      }
    }
    return lineList;
  }

  int? timeTagToTS(String timeTag) {
    if (timeTag.trim().isEmpty) return null;
    final match = timeTagPattern.firstMatch(timeTag);
    if (match == null) return null;
    return timestampMatchToMs(match);
  }

  static int? timestampMatchToMs(RegExpMatch match) {
    final minutes = int.tryParse(match.group(1) ?? '');
    final seconds = int.tryParse(match.group(2) ?? '');
    final fraction = match.group(3);
    if (minutes == null || seconds == null || fraction == null) return null;
    // 两位是厘秒，需要补成毫秒；超过三位则截断。
    final millis = int.parse(fraction.padRight(3, '0').substring(0, 3));
    return Duration(
      minutes: minutes,
      seconds: seconds,
      milliseconds: millis,
    ).inMilliseconds;
  }
}

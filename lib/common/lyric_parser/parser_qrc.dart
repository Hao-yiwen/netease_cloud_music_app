import 'package:netease_cloud_music_app/common/lyric_parser/LyricsLineModel.dart';
import 'package:netease_cloud_music_app/common/lyric_parser/lyrics_parse.dart';


/// 废弃
class ParserQrc extends LyricParse {
  RegExp advancedPattern = RegExp(r"""\[\d+,\d+]""");
  RegExp qrcPattern = RegExp(r"""\((\d+,\d+)\)""");

  RegExp advancedValuePattern = RegExp(r"\[(\d*,\d*)\]");

  ParserQrc(super.lyric);

  @override
  List<LyricsLineModel> parseLines({bool isMain = true}) {
    lyric =
        RegExp(r"""LyricContent="([\s\S]*)">""").firstMatch(lyric)?.group(1) ??
            lyric;

    var lines = lyric.split("\n");
    if (lines.isEmpty) {
      return [];
    }
    List<LyricsLineModel> lineList = [];
    lines.forEach((line) {
      var time = advancedPattern.stringMatch(line);
      if (time == null) {
        return;
      }
      // 转时间戳
      var ts = int.parse(
          advancedValuePattern.firstMatch(time)?.group(1)?.split(",")[0] ??
              "0");
      //移除时间
      var realLyrics = line.replaceFirst(advancedPattern, "");

      List<LyricSpanInfo> spanList = getSpanList(realLyrics);

      var lineModel = LyricsLineModel()
        ..mainText = realLyrics.replaceAll(qrcPattern, "")
        ..startTime = ts
        ..spanList = spanList;
      lineList.add(lineModel);
    });
    return lineList;
  }

  List<LyricSpanInfo> getSpanList(String realLyrics) {
    var invalidLength = 0;
    var startIndex = 0;
    var spanList = qrcPattern.allMatches(realLyrics).map((element) {
      var span = LyricSpanInfo();

      span.raw =
          realLyrics.substring(startIndex + invalidLength, element.start);

      var elementText = element.group(0) ?? "";
      span.index = startIndex;
      span.length = element.start - span.index - invalidLength;
      invalidLength += elementText.length;
      startIndex = element.start;

      var time = elementText.substring(1, elementText.length - 1).split(",");
      span.start = int.parse(time[0]);
      span.duration = int.parse(time[1]) - span.start;
      return span;
    }).toList();
    return spanList;
  }
}

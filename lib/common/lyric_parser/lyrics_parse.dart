import 'package:netease_cloud_music_app/common/lyric_parser/LyricsLineModel.dart';

abstract class LyricParse {
  String lyric;

  LyricParse(this.lyric);

  List<LyricsLineModel> parseLines({bool isMain = true});

  bool isOK() => true;
}

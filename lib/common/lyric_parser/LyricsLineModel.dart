class LyricsLineModel {
  String? mainText;
  String? extText;
  int? startTime;
  int? endTime;
  List<LyricSpanInfo>? spanList;

}

class LyricSpanInfo {
  int index = 0;
  int length = 0;
  int duration = 0;
  int start = 0;
  String raw = "";

  double drawWidth = 0;
  double drawHeight = 0;

  int get end => start + duration;

  int get endIndex => index + length;
}

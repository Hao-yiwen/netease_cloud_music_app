/// 播放列表下标与预加载地址的纯逻辑，方便单测，也避免把错误的缓存地址套到另一首歌上。
class PreparedSongUrl {
  final String songId;
  final String url;

  const PreparedSongUrl(this.songId, this.url);
}

/// 只在预加载地址确实属于当前歌曲时才使用。
String? takePreparedUrl(PreparedSongUrl? prepared, String songId) {
  if (prepared == null || prepared.songId != songId) return null;
  final url = prepared.url.trim();
  if (url.isEmpty) return null;
  return url;
}

int wrapPlaylistIndex(int index, int length) {
  if (length <= 0) return 0;
  final mod = index % length;
  return mod < 0 ? mod + length : mod;
}

int movePlaylistIndex(
  int current,
  int length, {
  required bool next,
  required bool repeatOne,
}) {
  if (length <= 0) return 0;
  if (repeatOne) return wrapPlaylistIndex(current, length);
  return wrapPlaylistIndex(next ? current + 1 : current - 1, length);
}

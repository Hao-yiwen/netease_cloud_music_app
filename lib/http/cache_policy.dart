/// 哪些 GET 可以进内存缓存。登录、用户态、播放地址不在这里，避免串号或拿到过期链接。
enum HttpCacheMode { none, cache, refresh }

const Set<String> publicCachePaths = {
  '/banner',
  '/homepage/block/page',
  '/top/playlist',
  '/personalized',
  '/personalized/djprogram',
  '/mv/all',
  '/search',
  '/search/suggest',
  '/hot/topic',
  '/topic/detail/event/hot',
  '/playlist/detail',
  '/song/detail',
  '/simi/song',
};

String normalizeRequestPath(String path) {
  final withoutQuery = path.split('?').first;
  if (withoutQuery.length > 1 && withoutQuery.endsWith('/')) {
    return withoutQuery.substring(0, withoutQuery.length - 1);
  }
  return withoutQuery;
}

bool isPublicCacheablePath(String path) {
  return publicCachePaths.contains(normalizeRequestPath(path));
}

HttpCacheMode resolveHttpCacheMode(String path, {required bool refresh}) {
  if (!isPublicCacheablePath(path)) return HttpCacheMode.none;
  return refresh ? HttpCacheMode.refresh : HttpCacheMode.cache;
}

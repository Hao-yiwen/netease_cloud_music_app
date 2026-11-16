/// 把用户输入收成 Dio 能用的接口根地址。
///
/// 没写协议时按本地服务处理，补上 `http://`。末尾保留 `/`，避免和相对路径拼出双斜杠或漏斜杠。
String normalizeBaseUrl(String raw) {
  var url = raw.trim();
  if (url.isEmpty) {
    throw const FormatException('接口地址不能为空');
  }
  if (!url.contains('://')) {
    url = 'http://$url';
  }
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    throw const FormatException('接口地址无效');
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    throw const FormatException('接口地址只支持 http 或 https');
  }
  if (!url.endsWith('/')) {
    url = '$url/';
  }
  return url;
}

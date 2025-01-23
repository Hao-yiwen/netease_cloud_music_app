import 'package:shared_preferences/shared_preferences.dart';

class UrlConstants {
    static final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    static const NETEASE_INFO_LIST = "https://fn.music.163.com/g/xrn/12cdffe6499557a8b53a8c5c0cca4b01?userid=265031418&dlt=0846&app_version=9.1.50";
    static const PLACE_IMAGE_HOLDER = "https://picsum.photos/100/100";

    static String? _baseUrl;

    static Future<String> get BASE_URL async {
        if (_baseUrl == null) {
            _baseUrl = await asyncPrefs.getString('BASE_URL') ?? 'https://neteasecloudmusicapi-one-tan.vercel.app/';
        }
        return _baseUrl!;
    }

    static Future<void> setBaseUrl(String url) async {
        await asyncPrefs.setString('BASE_URL', url);
        _baseUrl = url;
    }
}
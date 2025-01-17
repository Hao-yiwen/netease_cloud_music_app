final NETEASE_INFO_LIST =
    String.fromEnvironment('NETEASE_INFO_LIST', defaultValue: "https://fn.music.163.com/g/xrn/12cdffe6499557a8b53a8c5c0cca4b01?userid=265031418&dlt=0846&app_version=9.1.50");

// final BASE_URL = 'http://192.168.0.102:3000';
// final BASE_URL = 'http://39.105.115.83:3000/';
// We first try get from env, if not, use the default one
final BASE_URL = String.fromEnvironment('BASE_URL', defaultValue: 'https://neteasecloudmusicapi-one-tan.vercel.app/');

final PLACE_IMAGE_HOLDER = String.fromEnvironment('PLACE_IMAGE_HOLDER', defaultValue: 'https://picsum.photos/100/100');

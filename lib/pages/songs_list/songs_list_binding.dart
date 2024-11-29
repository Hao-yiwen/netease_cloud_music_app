import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/songs_list/song_list_controller.dart';

class SongsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SongListController());
  }
}

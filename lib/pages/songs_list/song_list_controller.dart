import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';

class SongListController extends GetxController {
  RxList<MediaItem> songs = <MediaItem>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString title = ''.obs;
  RxString picUrl = ''.obs;

  // 移除onInit中的参数获取，改为直接调用方法
  Future<void> getPlayListDetail(int id) async {
    try {
      isLoading.value = true;
      error.value = '';

      if (id <= 0) {
        error.value = '无效的歌单ID';
        return;
      }

      final lists = await MainController.to.getPlayListDetail(id);

      if (lists.isEmpty) {
        error.value = '暂无歌曲';
      } else {
        songs.value = lists;
        title.value = lists[0].extras?['title'] ?? '';
        picUrl.value = lists[0].extras?['image'] ?? '';
      }
    } catch (e) {
      error.value = '获取歌单失败: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}

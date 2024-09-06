import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_info_dto.dart';
import 'package:netease_cloud_music_app/http/api/roaming/roaming_api.dart';

class RoamingController extends GetxController {
  RxBool loading = false.obs;
  Rx<SongInfoDto> songInfo = SongInfoDto().obs;
  Rx<int> currentSongId = 1.obs;
  Rx<int> playStatus = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  getMusicInfo() async {
    loading.value = true;
    try {
      if (currentSongId.value == 1) {
        Fluttertoast.showToast(msg: '歌曲ID为空，无法获取歌曲信息');
        return;
      }
      SongInfoListDto songInfoListDto =
          await RoamingApi.getSongInfo(currentSongId.value);
      if (songInfoListDto.data?.isNotEmpty == true) {
        songInfo.value = songInfoListDto.data![0];
      }
    } catch (e) {
      LogBox.error(e.toString());
    } finally {
      loading.value = false;
    }
  }

  static RoamingController get to => Get.find<RoamingController>();
}

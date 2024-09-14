import 'package:audio_service/audio_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/roaming/dto/song_info_dto.dart';
import 'package:netease_cloud_music_app/http/api/roaming/roaming_api.dart';

import '../../common/music_handler.dart';

class RoamingController extends GetxController {
  RxBool loading = false.obs;
  // 歌词 播放列表pageview下标
  RxInt selectIndex = 0.obs;
  // audio handler
  final audioHandler = GetIt.instance<MusicHandler>();
  // 当前播放歌曲
  Rx<MediaItem> mediaItem =
      const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;
  // 当前播放列表
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  // 是否播放中
  RxBool playing = false.obs;
  // 是否是fm
  RxBool fm = false.obs;
  // 播放进度
  Rx<Duration> duration = Duration.zero.obs;
  Duration lastDuration = Duration.zero;
  // 循环方式
  Rx<AudioServiceRepeatMode> audioServiceRepeatMode =
      AudioServiceRepeatMode.all.obs;
  // 是否开启高音质
  RxBool high = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  static RoamingController get to => Get.find<RoamingController>();

  getMusicInfo() async {
    // loading.value = true;
    // try {
    //   if (currentSongId.value == 1) {
    //     Fluttertoast.showToast(msg: '歌曲ID为空，无法获取歌曲信息');
    //     return;
    //   }
    //   // 根据歌曲ID获取歌曲信息
    //   SongInfoListDto songInfoListDto =
    //       await RoamingApi.getSongInfo(currentSongId.value);
    //   if (songInfoListDto.data?.isNotEmpty == true) {
    //     songInfo.value = songInfoListDto.data![0];
    //   }
    // } catch (e) {
    //   LogBox.error(e);
    // } finally {
    //   loading.value = false;
    // }
  }
}

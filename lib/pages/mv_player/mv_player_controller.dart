import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/mv_player/dto/mv_detail.dart';
import 'package:netease_cloud_music_app/http/api/mv_player/mv_player_api.dart';

class MvPlayerController extends GetxController {
  RxBool loading = false.obs;
  Rx<MvDetail> mvDetail = MvDetail().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMvDetail(int id) async {
    try {
      loading.value = true;
      var res = await MvPlayerApi.getMvDetail(id);
      mvDetail.value = res;
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  static MvPlayerController get to => Get.find<MvPlayerController>();
}

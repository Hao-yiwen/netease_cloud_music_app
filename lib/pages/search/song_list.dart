import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';

class SongList extends GetView<SearchpageController> {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final songs = controller.searchResult.value.result?.songs;
      final searchSongs = controller.searchSongs.value;

      if (songs == null || songs.isEmpty || searchSongs.isEmpty) {
        return const Center(child: Text('暂无数据'));
      }

      return ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          if (index >= searchSongs.length) {
            return null;
          }
          return GestureDetector(
            key: ValueKey(searchSongs[index].id),
            onTap: () {
              RoamingController.to.playByIndex(
                index,
                'queueTitle',
                mediaItem: searchSongs,
              );
              Roaming.showBottomPlayer(context);
            },
            child: ListTile(
              title: Text(
                song.name ?? '',
                style: const TextStyle(color: Colours.blue),
              ),
              subtitle: Text(
                song.artists?.map((e) => e.name).join(' / ') ?? '',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              trailing: Icon(
                TablerIcons.player_play_filled,
                color: Colors.grey[400],
                size: 30.w,
              ),
            ),
          );
        },
      );
    });
  }
}

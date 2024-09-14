import 'package:audio_service/audio_service.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

/**
 * @data 2024/09/15
 * @desc 所有songDto接口都转化为mediaItem
 */
@RoutePage()
class SongsList extends StatelessWidget {
  final List<MediaItem> songs;
  final String title;

  const SongsList({super.key, required this.songs, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              RoamingController.to
                  .playByIndex(index, 'queueTitle', mediaItem: songs);
              Roaming.showBottomPlayer(context);
            },
            child: ListTile(
              title: Text(songs![index].title!),
              trailing:
                  NeteaseCacheImage(picUrl: songs![index].extras!['image']),
              subtitle: Text(songs![index].artist!),
            ),
          );
        },
        itemCount: songs!.length,
      ),
    );
  }
}

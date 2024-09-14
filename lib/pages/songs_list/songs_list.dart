import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../../http/api/main/dto/song_dto.dart';

@RoutePage()
class SongsList extends StatelessWidget {
  final List<SongDto> songs;
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
              // RoamingController.to.currentSongId.value = songs![index].id!;
              RoamingController.to.getMusicInfo();
              Roaming.showBottomPlayer(context);
            },
            child: ListTile(
              title: Text(songs![index].name!),
              trailing: NeteaseCacheImage(picUrl: songs![index].al!.picUrl!),
              subtitle: Text(songs![index].ar![0].name!),
            ),
          );
        },
        itemCount: songs!.length,
      ),
    );
  }
}

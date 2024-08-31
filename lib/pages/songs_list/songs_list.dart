import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';

@RoutePage()
class SongsList extends StatelessWidget {
  RecommendSongsDto recommendSongsDto;

  SongsList({super.key, required this.recommendSongsDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendSongsDto.dailySongs![index].name!),
            trailing: Image(
              // 缓存图片加速
              image: CachedNetworkImageProvider(
                  recommendSongsDto.dailySongs![index].al!.picUrl!),
            ),
            subtitle: Text(recommendSongsDto.dailySongs![index].ar![0].name!),
          );
        },
        itemCount: recommendSongsDto.dailySongs!.length,
      ),
    );
  }
}

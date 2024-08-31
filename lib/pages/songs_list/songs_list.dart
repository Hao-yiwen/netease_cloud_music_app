import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart';

@RoutePage()
class SongsList extends StatelessWidget {
  RecommendSongsDto recommendSongsDto;

  SongsList({super.key, required this.recommendSongsDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendSongsDto.dailySongs![index].name!),
            subtitle: Text(recommendSongsDto.dailySongs![index].ar![0].name!),
          );
        },
        itemCount: recommendSongsDto.dailySongs!.length,
      ),
    );
  }
}

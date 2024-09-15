import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../http/api/main/dto/personalized_djprogram_dto.dart';

class SongsListWidget extends StatelessWidget {
  final List<MediaItem> songs;

  const SongsListWidget({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = songs.length ~/ 3; // 6列
    List<List<MediaItem>> songsMatrix = [];
    for (int i = 0; i < itemCount; i++) {
      songsMatrix.add(songs.sublist(i * 3, i * 3 + 3));
    }
    return SizedBox(
      height: 300.h,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.9, // 每列占90%的宽度
        ),
        itemCount: itemCount, // 总共6列
        itemBuilder: (context, pageIndex) {
          // 根据 pageIndex 计算偏移量
          double offsetX = ScreenUtil().screenWidth * 0.05 * (pageIndex - 1);

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: Column(
                // list to map to get index
                children: songsMatrix[pageIndex].asMap().entries.map((entry) {
                  return SongCell(
                    title: entry.value.title ?? '',
                    artist: entry.value.artist ?? '',
                    picUrl: entry.value.extras?['image'] ?? '',
                    onTapItem: () {
                      RoamingController.to
                          .playByIndex(entry.key, 'songs', mediaItem: songs);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgramListWidget extends StatelessWidget {
  final List<DjProgram> programs;

  const ProgramListWidget({
    super.key,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = programs.length ~/ 3; // 6列
    List<List<DjProgram>> songsMatrix = [];
    for (int i = 0; i < itemCount; i++) {
      songsMatrix.add(programs.sublist(i * 3, i * 3 + 3));
    }
    return SizedBox(
      height: 300.h,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.9, // 每列占90%的宽度
        ),
        itemCount: itemCount, // 总共6列
        itemBuilder: (context, pageIndex) {
          // 根据 pageIndex 计算偏移量
          double offsetX = ScreenUtil().screenWidth * 0.05 * (pageIndex - 1);

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: Column(
                children: songsMatrix[pageIndex]
                    .map((pragma) => SongCell(
                          title: pragma.name!,
                          artist: pragma.copywriter!,
                          picUrl: pragma.picUrl!,
                          onTapItem: () {},
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PodcastListWidget extends StatelessWidget {
  final List<DjProgram> programs;

  const PodcastListWidget({
    super.key,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = programs.length ~/ 3; // 6列
    List<List<DjProgram>> songsMatrix = [];
    for (int i = 0; i < itemCount; i++) {
      songsMatrix.add(programs.sublist(i * 3, i * 3 + 3));
    }
    return SizedBox(
      height: 300.h,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.9, // 每列占90%的宽度
        ),
        itemCount: itemCount, // 总共6列
        itemBuilder: (context, pageIndex) {
          // 根据 pageIndex 计算偏移量
          double offsetX = ScreenUtil().screenWidth * 0.05 * (pageIndex - 1);

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: Column(
                children: songsMatrix[pageIndex]
                    .map((pragma) => PodcastCell(
                          title: pragma.name!,
                          artist: pragma.copywriter!,
                          picUrl: pragma.picUrl!,
                          onTapItem: () {},
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SongCell extends StatelessWidget {
  final String title;
  final String artist;
  final String picUrl;
  String? tag;
  final Function onTapItem;

  SongCell(
      {super.key,
      required this.title,
      required this.artist,
      required this.picUrl,
      this.tag,
      required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem();
      },
      child: Container(
          height: 80.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.w), // 设置圆角半径
                child:
                    NeteaseCacheImage(picUrl: picUrl, size: Size(100.w, 100.w)),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // 添加省略号
                      maxLines: 1, // 设置最多显示一行
                    ),
                    Text(
                      artist,
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: Colors.grey[400],
                      ),
                      overflow: TextOverflow.ellipsis, // 添加省略号
                      maxLines: 1, // 设置最多显示一行
                    ),
                  ],
                ),
              ),
              Icon(
                TablerIcons.player_play_filled,
                size: 30.w,
                color: Colors.grey[600],
              ),
              SizedBox(width: 20.w),
            ],
          )),
    );
  }
}

class PodcastCell extends StatelessWidget {
  final String title;
  final String artist;
  final String picUrl;
  String? tag;
  final Function onTapItem;

  PodcastCell(
      {super.key,
      required this.title,
      required this.artist,
      required this.picUrl,
      this.tag,
      required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem();
      },
      child: Container(
          height: 80.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.w), // 设置圆角半径
                child:
                    NeteaseCacheImage(picUrl: picUrl, size: Size(100.w, 100.w)),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // 添加省略号
                      maxLines: 1, // 设置最多显示一行
                    ),
                    Text(
                      artist,
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: Colors.grey[400],
                      ),
                      overflow: TextOverflow.ellipsis, // 添加省略号
                      maxLines: 1, // 设置最多显示一行
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
            ],
          )),
    );
  }
}

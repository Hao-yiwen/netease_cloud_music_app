import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

final CARD_HEIGHT = 278.w;

class RecommendPlayListCard extends StatelessWidget {
  const RecommendPlayListCard(
      {super.key,
      required this.recommendPlayList,
      required this.onTapItemIndex});

  final List<RecommendPlaylist> recommendPlayList;
  final Function onTapItemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
          height: CARD_HEIGHT,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SongCard(
                  picUrl: recommendPlayList[index].picUrl ?? '',
                  title: recommendPlayList[index].name ?? '',
                  playCount: recommendPlayList[index]!.playcount ?? 0,
                  onTapItem: () {
                    onTapItemIndex(index);
                  },
                ),
              );
            },
            itemCount: recommendPlayList.length,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}

//
class PlayListCard extends StatelessWidget {
  const PlayListCard(
      {super.key, required this.playList, required this.onTapItemIndex});

  final List<Playlist> playList;
  final Function onTapItemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
          height: CARD_HEIGHT,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SongCard(
                  picUrl: playList[index].coverImgUrl ?? '',
                  title: playList[index].name ?? '',
                  playCount: playList[index].playCount ?? 0,
                  onTapItem: () {
                    onTapItemIndex(index);
                  },
                ),
              );
            },
            itemCount: playList.length,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}

class SongCard extends StatelessWidget {
  SongCard(
      {super.key,
      required this.picUrl,
      required this.title,
      this.playCount,
      required this.onTapItem});

  final String picUrl;
  final String title;
  int? playCount;
  final Function onTapItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem();
      },
      child: SizedBox(
        height: double.infinity,
        width: 178.w,
        child: Column(
          children: [
            Container(
              width: 178.w,
              height: 198.w,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.w),
                  image: DecorationImage(
                    image: NeteaseCacheImage(picUrl: picUrl).getImageProvider(),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                children: [
                  if (playCount != null)
                    Padding(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            TablerIcons.headphones_filled,
                            color: Colors.white,
                            size: 20.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            getFormattedNumber(playCount!),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
            SizedBox(height: 10.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title,
                    style: TextStyle(fontSize: 22.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getFormattedNumber(int i) {
  if (i < 10000) {
    return '$i';
  } else if (i < 100000000) {
    return '${i ~/ 10000}万';
  } else {
    return '${i ~/ 100000000}亿';
  }
}

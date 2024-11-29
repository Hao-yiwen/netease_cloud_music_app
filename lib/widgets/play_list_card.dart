import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

const double _cardHeight = 278;

class RecommendPlayListCard extends StatelessWidget {
  const RecommendPlayListCard({
    super.key,
    required this.recommendPlayList,
    required this.onTapItemIndex,
  });

  final List<RecommendPlaylist> recommendPlayList;
  final Function onTapItemIndex;

  @override
  Widget build(BuildContext context) {
    return _buildPlayListView(
      itemCount: recommendPlayList.length,
      itemBuilder: (context, index) {
        final item = recommendPlayList[index];
        return _buildCard(
          picUrl: item.picUrl ?? '',
          title: item.name ?? '',
          playCount: item.playcount,
          onTap: () => onTapItemIndex(index),
        );
      },
    );
  }
}

class PlayListCard extends StatelessWidget {
  const PlayListCard({
    super.key,
    required this.playList,
    required this.onTapItemIndex,
  });

  final List<Playlist> playList;
  final Function onTapItemIndex;

  @override
  Widget build(BuildContext context) {
    return _buildPlayListView(
      itemCount: playList.length,
      itemBuilder: (context, index) {
        final item = playList[index];
        return _buildCard(
          picUrl: item.coverImgUrl ?? '',
          title: item.name ?? '',
          playCount: item.playCount,
          onTap: () => onTapItemIndex(index),
        );
      },
    );
  }
}

Widget _buildPlayListView({
  required int itemCount,
  required Widget Function(BuildContext, int) itemBuilder,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: SizedBox(
      height: _cardHeight.w,
      child: ListView.builder(
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: itemBuilder,
      ),
    ),
  );
}

Widget _buildCard({
  required String picUrl,
  required String title,
  int? playCount,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: SongCard(
      picUrl: picUrl,
      title: title,
      playCount: playCount,
      onTapItem: onTap,
    ),
  );
}

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.picUrl,
    required this.title,
    this.playCount,
    required this.onTapItem,
  });

  final String picUrl;
  final String title;
  final int? playCount;
  final VoidCallback onTapItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: SizedBox(
        height: double.infinity,
        width: 178.w,
        child: Column(
          children: [
            _buildCoverImage(),
            SizedBox(height: 10.w),
            _buildTitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      width: 178.w,
      height: 198.w,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.w),
        image: DecorationImage(
          image: NetworkImage(picUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: _buildPlayCount(),
    );
  }

  Widget _buildPlayCount() {
    if (playCount == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: 5.w),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Icon(
            TablerIcons.headphones_filled,
            color: Colors.white,
            size: 20.w,
          ),
          SizedBox(width: 5.w),
          Text(
            _formatNumber(playCount!),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 22.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

String _formatNumber(int number) {
  if (number < 10000) {
    return '$number';
  } else if (number < 100000000) {
    return '${number ~/ 10000}万';
  } else {
    return '${number ~/ 100000000}亿';
  }
}

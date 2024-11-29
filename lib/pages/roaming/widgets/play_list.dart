import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';

class PlayList extends StatelessWidget {
  final List<MediaItem> mediaItems;
  final MediaItem currentItem;
  final Function onItemTap;
  final bool playing;

  const PlayList({
    super.key,
    required this.mediaItems,
    required this.currentItem,
    required this.onItemTap,
    required this.playing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      scrollDirection: Axis.vertical,
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final item = mediaItems[index];
        final isCurrentItem = item == currentItem;

        return _buildListItem(
          context: context,
          item: item,
          isCurrentItem: isCurrentItem,
          index: index,
          theme: theme,
        );
      },
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required MediaItem item,
    required bool isCurrentItem,
    required int index,
    required ThemeData theme,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: isCurrentItem
            ? Color(0xFF8E9FFF).withOpacity(0.15) // 使用一个柔和的蓝紫色作为背景
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12.w),
        border: isCurrentItem
            ? Border.all(color: Color(0xFF8E9FFF).withOpacity(0.5))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.w),
          onTap: () => onItemTap(index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            child: Row(
              children: [
                if (isCurrentItem) ...[
                  Container(
                    width: 6.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF8E9FFF), // 使用相同的蓝紫色作为指示条
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isCurrentItem
                              ? Color(0xFF8E9FFF) // 使用相同的蓝紫色作为文字颜色
                              : theme.textTheme.bodyLarge?.color,
                          fontSize: 28.sp,
                          fontWeight: isCurrentItem
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        item.artist ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.8),
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCurrentItem) ...[
                  SizedBox(width: 12.w),
                  _buildPlayingIndicator(theme),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayingIndicator(ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 32.w,
      width: 32.w,
      child: Image.asset(
        ImageUtils.getImagePath(
          playing ? 'video_playlist_icn_playing' : 'c2w',
        ),
        color: theme.colorScheme.primary,
      ),
    );
  }
}

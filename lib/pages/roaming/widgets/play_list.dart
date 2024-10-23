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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var borderRadius = BorderRadius.all(Radius.circular(10.w));
        return GestureDetector(
          onTap: () {
            onItemTap(index);
          },
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            contentPadding: EdgeInsets.zero,
            tileColor: mediaItems[index] == currentItem
                ? Colors.grey.withOpacity(0.2)
                : Colors.transparent,
            title: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                children: [
                  Text(
                    mediaItems[index].title,
                    style: const TextStyle(color: Colors.black),
                    // Text color for better contrast
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    (mediaItems[index].artist ?? ''),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    // Text color for better contrast
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            trailing: mediaItems[index] == currentItem
                ? Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: playing
                        ? Image.asset(
                            ImageUtils.getImagePath(
                                'video_playlist_icn_playing'),
                            height: 40.w,
                            width: 40.h,
                            color: Colors.red)
                        : Image.asset(ImageUtils.getImagePath('c2w'),
                            height: 40.w, width: 40.h, color: Colors.red),
                  )
                : null,
          ),
        );
      },
      itemCount: mediaItems.length,
    );
  }
}

// ignore: implementation_imports
import 'package:auto_route/src/route/page_route_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/pages/mv_player/mv_player.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

class MvList extends GetView<SearchpageController> {
  const MvList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mvs = controller.searchMvs.value.result?.mvs;
      if (mvs == null || mvs.isEmpty) {
        return const Center(child: Text('暂无数据'));
      }

      return ListView.builder(
        itemCount: mvs.length,
        itemBuilder: (context, index) {
          final mv = mvs[index];
          return GestureDetector(
            key: ValueKey(mv.id),
            onTap: () => _handleMvTap(mv),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: NeteaseCacheImage(picUrl: mv.cover ?? ''),
              ),
              title: Text(
                mv.name ?? '',
                style: const TextStyle(color: Colours.blue),
                maxLines: 1,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mv.artists?.map((e) => e.name).join(' / ') ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    maxLines: 1,
                  ),
                  Text(
                    '播放量：${mv.playCount}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _handleMvTap(dynamic mv) {
    GetIt.instance<AppRouter>().push(
      MvPlayer(
        title: mv.name ?? '',
        id: mv.id ?? 0,
        artist: mv.artists?.map((e) => e.name).join(' / ') ?? '',
      ) as PageRouteInfo,
    );
  }
}

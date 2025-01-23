import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

@RoutePage()
class CommentPage extends StatelessWidget {
  CommentPage({super.key});

  final RoamingController _controller = RoamingController.to;

  Widget _buildCommentHeader(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Text(
        '评论(${_controller.commentCount.value})',
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.withOpacity(0.1), Colors.transparent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCommentAvatar(String? avatarUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 2.w,
        ),
      ),
      child: ClipOval(
        child: NeteaseCacheImage(
          picUrl: avatarUrl ?? UrlConstants.PLACE_IMAGE_HOLDER,
          size: Size(55.w, 55.w),
        ),
      ),
    );
  }

  Widget _buildCommentUserInfo(
      BuildContext context, String? nickname, String? timeStr) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        nickname ?? '',
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text(
        timeStr ?? '',
        style: TextStyle(
          fontSize: 22.sp,
          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildCommentContent(BuildContext context, String? content) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 70.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content ?? '',
            style: TextStyle(
              fontSize: 24.sp,
              height: 1.5,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            height: 0.5.w,
            color: Colors.red.withOpacity(0.1),
          )
        ],
      ),
    );
  }

  Widget _buildCommentItem(BuildContext context, dynamic comment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: _buildCommentAvatar(comment.user?.avatarUrl),
              ),
              Expanded(
                child: Column(
                  children: [
                    _buildCommentUserInfo(
                      context,
                      comment.user?.nickname,
                      comment.timeStr,
                    ),
                  ],
                ),
              )
            ],
          ),
          _buildCommentContent(context, comment.content),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '评论',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Obx(() {
          return Column(
            children: [
              _buildCommentHeader(context),
              Flexible(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _controller.comments.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = _controller.comments.value[sectionIndex];
                    return Column(
                      children: [
                        _buildSectionHeader(section.title ?? ''),
                        Column(
                          children: List.generate(
                            section.comments?.length ?? 0,
                            (itemIndex) => _buildCommentItem(
                              context,
                              section.comments?[itemIndex],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

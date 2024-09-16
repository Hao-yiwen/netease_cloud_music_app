// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentSection _$CommentSectionFromJson(Map<String, dynamic> json) =>
    CommentSection()
      ..title = json['title'] as String?
      ..comments = (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CommentSectionToJson(CommentSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'comments': instance.comments,
    };

CommentMusic _$CommentMusicFromJson(Map<String, dynamic> json) => CommentMusic()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..total = (json['total'] as num?)?.toInt()
  ..userId = (json['userId'] as num?)?.toInt()
  ..isMusician = json['isMusician'] as bool?
  ..comments = (json['comments'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList()
  ..hotComments = (json['hotComments'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList()
  ..topComments = (json['topComments'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$CommentMusicToJson(CommentMusic instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'total': instance.total,
      'userId': instance.userId,
      'isMusician': instance.isMusician,
      'comments': instance.comments,
      'hotComments': instance.hotComments,
      'topComments': instance.topComments,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment()
  ..user = json['user'] == null
      ? null
      : UserProfile.fromJson(json['user'] as Map<String, dynamic>)
  ..content = json['content'] as String?
  ..time = (json['time'] as num?)?.toInt()
  ..timeStr = json['timeStr'] as String?
  ..likedCount = (json['likedCount'] as num?)?.toInt()
  ..liked = json['liked'] as bool?
  ..commentId = (json['commentId'] as num?)?.toInt();

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'user': instance.user,
      'content': instance.content,
      'time': instance.time,
      'timeStr': instance.timeStr,
      'likedCount': instance.likedCount,
      'liked': instance.liked,
      'commentId': instance.commentId,
    };

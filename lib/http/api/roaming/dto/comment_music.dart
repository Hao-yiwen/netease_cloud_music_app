import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../../../models/user/user_profile.dart';

part 'comment_music.g.dart';

@JsonSerializable()
class CommentSection {
  String? title;
  List<Comment>? comments;

  CommentSection();

  factory CommentSection.fromJson(Map<String, dynamic> json) =>
      _$CommentSectionFromJson(json);

  Map<String, dynamic> toJson() => _$CommentSectionToJson(this);
}

@JsonSerializable()
class CommentMusic extends ServerStatusBean {
  int? total;
  int? userId;
  bool? isMusician;
  List<Comment>? comments;
  List<Comment>? hotComments;
  List<Comment>? topComments;

  CommentMusic();

  factory CommentMusic.fromJson(Map<String, dynamic> json) =>
      _$CommentMusicFromJson(json);

  Map<String, dynamic> toJson() => _$CommentMusicToJson(this);
}

@JsonSerializable()
class Comment {
  UserProfile? user;
  String? content;
  int? time;
  String? timeStr;
  int? likedCount;
  bool? liked;
  int? commentId;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

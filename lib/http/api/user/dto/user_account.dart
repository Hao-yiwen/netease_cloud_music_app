import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount extends ServerStatusBean {
  int? level;
  int? listenSongs;
  bool? mobileSign;
  bool? pcSign;
  bool? peopleCanSeeMyPlayRecord;
  int? createDays;
  int? createTime;
  bool? recallUser;
  bool? newUser;
  bool? adValid;
  UserProfile? profile;

  UserAccount();

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}

@JsonSerializable()
class UserProfile {
  int? birthday;
  bool? defaultAvatar;
  String? description;
  String? detailDescription;
  String? expertTags;
  bool? followed;
  int? gender;
  String? nickname;
  bool? mutual;
  int? followeds;
  int? follows;
  int? province;
  int? city;
  String? avatarUrl;
  String? backgroundUrl;
  int? userId;
  String? signature;
  int? newFollows;
  int? playlistCount;

  UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

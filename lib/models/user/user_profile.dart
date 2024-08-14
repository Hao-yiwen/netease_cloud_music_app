import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';


@JsonSerializable()
class UserProfile{
  final int userId;
  final int userType;
  final String nickname;
  final int avatarImgId;
  final String avatarUrl;
  final int backgroundImgId;
  final String backgroundUrl;
  final String signature;
  final int createTime;
  final String userName;
  final int accountType;
  final String shortUserName;
  final int birthday;
  final int authority;
  final int gender;
  final int accountStatus;
  final int province;

  UserProfile({required this.userId, required this.userType, required this.nickname, required this.avatarImgId, required this.avatarUrl, required this.backgroundImgId, required this.backgroundUrl, required this.signature, required this.createTime, required this.userName, required this.accountType, required this.shortUserName, required this.birthday, required this.authority, required this.gender, required this.accountStatus, required this.province});

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
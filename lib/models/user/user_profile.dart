import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  int? userId;
  int? userType;
  String? nickname;
  int? avatarImgId;
  String? avatarUrl;
  int? backgroundImgId;
  String? backgroundUrl;
  String? signature;
  int? createTime;
  String? userName;
  int? accountType;
  String? shortUserName;
  int? birthday;
  int? authority;
  int? gender;
  int? accountStatus;
  int? province;
  VipRights? vipRights;

  UserProfile(
      {this.userId,
      this.userType,
      this.nickname,
      this.avatarImgId,
      this.avatarUrl,
      this.backgroundImgId,
      this.backgroundUrl,
      this.signature,
      this.createTime,
      this.userName,
      this.accountType,
      this.shortUserName,
      this.birthday,
      this.authority,
      this.gender,
      this.accountStatus,
      this.province});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class VipRights {
  Associator? associator;

  VipRights();

  factory VipRights.fromJson(Map<String, dynamic> json) =>
      _$VipRightsFromJson(json);

  Map<String, dynamic> toJson() => _$VipRightsToJson(this);
}

@JsonSerializable()
class Associator {
  bool? rights;
  String? iconUrl;

  Associator();

  factory Associator.fromJson(Map<String, dynamic> json) =>
      _$AssociatorFromJson(json);

  Map<String, dynamic> toJson() => _$AssociatorToJson(this);
}

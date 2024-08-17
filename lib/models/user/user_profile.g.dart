// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      userId: (json['userId'] as num).toInt(),
      userType: (json['userType'] as num).toInt(),
      nickname: json['nickname'] as String?,
      avatarImgId: (json['avatarImgId'] as num?)?.toInt(),
      avatarUrl: json['avatarUrl'] as String?,
      backgroundImgId: (json['backgroundImgId'] as num?)?.toInt(),
      backgroundUrl: json['backgroundUrl'] as String?,
      signature: json['signature'] as String?,
      createTime: (json['createTime'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      accountType: (json['accountType'] as num?)?.toInt(),
      shortUserName: json['shortUserName'] as String?,
      birthday: (json['birthday'] as num?)?.toInt(),
      authority: (json['authority'] as num?)?.toInt(),
      gender: (json['gender'] as num?)?.toInt(),
      accountStatus: (json['accountStatus'] as num?)?.toInt(),
      province: (json['province'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userType': instance.userType,
      'nickname': instance.nickname,
      'avatarImgId': instance.avatarImgId,
      'avatarUrl': instance.avatarUrl,
      'backgroundImgId': instance.backgroundImgId,
      'backgroundUrl': instance.backgroundUrl,
      'signature': instance.signature,
      'createTime': instance.createTime,
      'userName': instance.userName,
      'accountType': instance.accountType,
      'shortUserName': instance.shortUserName,
      'birthday': instance.birthday,
      'authority': instance.authority,
      'gender': instance.gender,
      'accountStatus': instance.accountStatus,
      'province': instance.province,
    };

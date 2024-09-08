// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..level = (json['level'] as num?)?.toInt()
  ..listenSongs = (json['listenSongs'] as num?)?.toInt()
  ..mobileSign = json['mobileSign'] as bool?
  ..pcSign = json['pcSign'] as bool?
  ..peopleCanSeeMyPlayRecord = json['peopleCanSeeMyPlayRecord'] as bool?
  ..createDays = (json['createDays'] as num?)?.toInt()
  ..createTime = (json['createTime'] as num?)?.toInt()
  ..recallUser = json['recallUser'] as bool?
  ..newUser = json['newUser'] as bool?
  ..adValid = json['adValid'] as bool?
  ..profile = json['profile'] == null
      ? null
      : UserProfile.fromJson(json['profile'] as Map<String, dynamic>);

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'level': instance.level,
      'listenSongs': instance.listenSongs,
      'mobileSign': instance.mobileSign,
      'pcSign': instance.pcSign,
      'peopleCanSeeMyPlayRecord': instance.peopleCanSeeMyPlayRecord,
      'createDays': instance.createDays,
      'createTime': instance.createTime,
      'recallUser': instance.recallUser,
      'newUser': instance.newUser,
      'adValid': instance.adValid,
      'profile': instance.profile,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile()
  ..birthday = (json['birthday'] as num?)?.toInt()
  ..defaultAvatar = json['defaultAvatar'] as bool?
  ..description = json['description'] as String?
  ..detailDescription = json['detailDescription'] as String?
  ..followed = json['followed'] as bool?
  ..gender = (json['gender'] as num?)?.toInt()
  ..nickname = json['nickname'] as String?
  ..mutual = json['mutual'] as bool?
  ..followeds = (json['followeds'] as num?)?.toInt()
  ..follows = (json['follows'] as num?)?.toInt()
  ..province = (json['province'] as num?)?.toInt()
  ..city = (json['city'] as num?)?.toInt()
  ..avatarUrl = json['avatarUrl'] as String?
  ..backgroundUrl = json['backgroundUrl'] as String?
  ..userId = (json['userId'] as num?)?.toInt()
  ..signature = json['signature'] as String?
  ..newFollows = (json['newFollows'] as num?)?.toInt()
  ..playlistCount = (json['playlistCount'] as num?)?.toInt();

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'defaultAvatar': instance.defaultAvatar,
      'description': instance.description,
      'detailDescription': instance.detailDescription,
      'followed': instance.followed,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'mutual': instance.mutual,
      'followeds': instance.followeds,
      'follows': instance.follows,
      'province': instance.province,
      'city': instance.city,
      'avatarUrl': instance.avatarUrl,
      'backgroundUrl': instance.backgroundUrl,
      'userId': instance.userId,
      'signature': instance.signature,
      'newFollows': instance.newFollows,
      'playlistCount': instance.playlistCount,
    };

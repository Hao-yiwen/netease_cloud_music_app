// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      id: (json['id'] as num).toInt(),
      userName: json['userName'] as String?,
      type: (json['type'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      createTime: (json['createTime'] as num?)?.toInt(),
      ban: (json['ban'] as num?)?.toInt(),
      vipType: (json['vipType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'type': instance.type,
      'status': instance.status,
      'createTime': instance.createTime,
      'ban': instance.ban,
      'vipType': instance.vipType,
    };

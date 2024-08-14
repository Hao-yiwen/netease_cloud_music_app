// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      id: (json['id'] as num).toInt(),
      userName: json['userName'] as String,
      type: (json['type'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      whitelistAuthority: (json['whitelistAuthority'] as num?)?.toInt(),
      createTime: (json['createTime'] as num?)?.toInt(),
      tokenVersion: (json['tokenVersion'] as num?)?.toInt(),
      ban: (json['ban'] as num?)?.toInt(),
      baoyueVersion: (json['baoyueVersion'] as num?)?.toInt(),
      donateVersion: (json['donateVersion'] as num?)?.toInt(),
      vipType: (json['vipType'] as num?)?.toInt(),
      anonimousUser: json['anonimousUser'] as bool?,
      paidFee: json['paidFee'] as bool?,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'type': instance.type,
      'status': instance.status,
      'whitelistAuthority': instance.whitelistAuthority,
      'createTime': instance.createTime,
      'tokenVersion': instance.tokenVersion,
      'ban': instance.ban,
      'baoyueVersion': instance.baoyueVersion,
      'donateVersion': instance.donateVersion,
      'vipType': instance.vipType,
      'anonimousUser': instance.anonimousUser,
      'paidFee': instance.paidFee,
    };

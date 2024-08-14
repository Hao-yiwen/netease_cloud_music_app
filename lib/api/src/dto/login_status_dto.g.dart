// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginStatusDto _$LoginStatusDtoFromJson(Map<String, dynamic> json) =>
    LoginStatusDto(
      code: (json['code'] as num).toInt(),
      account: json['account'] == null
          ? null
          : UserAccount.fromJson(json['account'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginStatusDtoToJson(LoginStatusDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'account': instance.account,
      'profile': instance.profile,
    };

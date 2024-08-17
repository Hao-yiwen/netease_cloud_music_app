// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerStatusBean _$ServerStatusBeanFromJson(Map<String, dynamic> json) =>
    ServerStatusBean()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$ServerStatusBeanToJson(ServerStatusBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
    };

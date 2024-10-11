// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mv_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MvDetail _$MvDetailFromJson(Map<String, dynamic> json) => MvDetail()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..data = json['data'] == null
      ? null
      : MvData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$MvDetailToJson(MvDetail instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

MvData _$MvDataFromJson(Map<String, dynamic> json) => MvData()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..id = (json['id'] as num?)?.toInt()
  ..url = json['url'] as String?
  ..size = (json['size'] as num?)?.toInt();

Map<String, dynamic> _$MvDataToJson(MvData instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'id': instance.id,
      'url': instance.url,
      'size': instance.size,
    };

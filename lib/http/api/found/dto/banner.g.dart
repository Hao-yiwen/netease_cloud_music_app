// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..banners = (json['banners'] as List<dynamic>?)
      ?.map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'banners': instance.banners,
    };

BannerItem _$BannerItemFromJson(Map<String, dynamic> json) => BannerItem()
  ..bannerId = json['bannerId'] as String?
  ..pic = json['pic'] as String?
  ..url = json['url'] as String?
  ..typeTitle = json['typeTitle'] as String?
  ..adDispatchJson = json['adDispatchJson'] as String?
  ..adurlV2 = json['adurlV2'] as String?
  ..showContext = json['showContext'] as String?;

Map<String, dynamic> _$BannerItemToJson(BannerItem instance) =>
    <String, dynamic>{
      'bannerId': instance.bannerId,
      'pic': instance.pic,
      'url': instance.url,
      'typeTitle': instance.typeTitle,
      'adDispatchJson': instance.adDispatchJson,
      'adurlV2': instance.adurlV2,
      'showContext': instance.showContext,
    };

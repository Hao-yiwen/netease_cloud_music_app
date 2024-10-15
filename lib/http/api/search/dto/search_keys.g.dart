// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeys _$SearchKeysFromJson(Map<String, dynamic> json) => SearchKeys(
      result: json['result'] == null
          ? null
          : _SearchResult.fromJson(json['result'] as Map<String, dynamic>),
    )
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$SearchKeysToJson(SearchKeys instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

_SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    _SearchResult(
      allMatch: (json['allMatch'] as List<dynamic>?)
          ?.map((e) => MatchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(_SearchResult instance) =>
    <String, dynamic>{
      'allMatch': instance.allMatch,
    };

MatchItem _$MatchItemFromJson(Map<String, dynamic> json) => MatchItem(
      keyword: json['keyword'] as String?,
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MatchItemToJson(MatchItem instance) => <String, dynamic>{
      'keyword': instance.keyword,
      'type': instance.type,
    };

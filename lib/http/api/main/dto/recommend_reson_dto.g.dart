// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_reson_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendReasonDto _$RecommendReasonDtoFromJson(Map<String, dynamic> json) =>
    RecommendReasonDto(
      songId: (json['songId'] as num).toInt(),
      reason: json['reason'] as String,
      reasonId: (json['reasonId'] as num).toInt(),
    )..targetUrl = json['targetUrl'] as String?;

Map<String, dynamic> _$RecommendReasonDtoToJson(RecommendReasonDto instance) =>
    <String, dynamic>{
      'songId': instance.songId,
      'reason': instance.reason,
      'reasonId': instance.reasonId,
      'targetUrl': instance.targetUrl,
    };

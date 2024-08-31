import 'package:json_annotation/json_annotation.dart';

part 'recommend_reson_dto.g.dart';

@JsonSerializable()
class RecommendReasonDto {
  int songId;
  String reason;
  int reasonId;
  String? targetUrl;

  RecommendReasonDto({
    required this.songId,
    required this.reason,
    required this.reasonId,
  });

  factory RecommendReasonDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendReasonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendReasonDtoToJson(this);
}

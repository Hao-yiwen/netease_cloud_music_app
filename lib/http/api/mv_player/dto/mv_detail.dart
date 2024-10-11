import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'mv_detail.g.dart';

@JsonSerializable()
class MvDetail extends ServerStatusBean{
  MvData? data;

  MvDetail();

  factory MvDetail.fromJson(Map<String, dynamic> json) => _$MvDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MvDetailToJson(this);
}

@JsonSerializable()
class MvData extends ServerStatusBean{
  int? id;
  String? url;
  int? size;

  MvData();

  factory MvData.fromJson(Map<String, dynamic> json) => _$MvDataFromJson(json);

  Map<String, dynamic> toJson() => _$MvDataToJson(this);
}
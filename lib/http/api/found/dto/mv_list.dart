import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'mv_list.g.dart';

@JsonSerializable()
class MvList extends ServerStatusBean{
  int? count;
  List<Mv>? data;

  MvList();

  factory MvList.fromJson(Map<String, dynamic> json) => _$MvListFromJson(json);

  Map<String, dynamic> toJson() => _$MvListToJson(this);
}

@JsonSerializable()
class Mv {
  int? id;
  String? cover;
  String? name;
  int? playCount;
  String? artistName;
  int? duration;

  Mv();

  factory Mv.fromJson(Map<String, dynamic> json) => _$MvFromJson(json);

  Map<String, dynamic> toJson() => _$MvToJson(this);
}
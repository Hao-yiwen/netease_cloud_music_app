import 'package:json_annotation/json_annotation.dart';

import '../../bean.dart';

part 'song_info_dto.g.dart';

@JsonSerializable()
class SongInfoDto extends ServerStatusBean {
  int? id;
  String? url;
  String? md5;
  int? time;
  String? mp3;
  String? level;

  SongInfoDto();

  factory SongInfoDto.fromJson(Map<String, dynamic> json) =>
      _$SongInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongInfoDtoToJson(this);
}

@JsonSerializable()
class SongInfoListDto  extends ServerStatusBean {
  List<SongInfoDto>? data;

  SongInfoListDto();

  factory SongInfoListDto.fromJson(Map<String, dynamic> json) =>
      _$SongInfoListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongInfoListDtoToJson(this);
}

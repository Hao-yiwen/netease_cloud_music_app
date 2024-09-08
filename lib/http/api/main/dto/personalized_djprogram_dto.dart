import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'personalized_djprogram_dto.g.dart';

@JsonSerializable()
class PersonalizedDjprogramDto extends ServerStatusBean {
  List<DjProgram>? result;

  PersonalizedDjprogramDto();

  factory PersonalizedDjprogramDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedDjprogramDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedDjprogramDtoToJson(this);
}

@JsonSerializable()
class DjProgram {
  int? id;
  int? type;
  String? name;
  String? picUrl;
  String? copywriter;

  DjProgram();

  factory DjProgram.fromJson(Map<String, dynamic> json) =>
      _$DjProgramFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramToJson(this);
}

@JsonSerializable()
class Program {
  MainSong? mainSong;
  String? blurCoverUrl;
  String? coverUrl;
  int? id;
  String? name;
  int? createTime;
}

@JsonSerializable()
class MainSong {
  String? name;
  int? id;
  int? duration;

  MainSong();

  factory MainSong.fromJson(Map<String, dynamic> json) =>
      _$MainSongFromJson(json);

  Map<String, dynamic> toJson() => _$MainSongToJson(this);
}

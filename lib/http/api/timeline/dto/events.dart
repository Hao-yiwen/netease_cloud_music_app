import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

import '../../../../models/user/user_profile.dart';

part 'events.g.dart';

@JsonSerializable()
class Events extends ServerStatusBean{
  int? size;
  List<Event>? events;

  Events();

  factory Events.fromJson(Map<String, dynamic> json) {
    return _$EventsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventsToJson(this);
  }
}

@JsonSerializable()
class Event {
  String? actName;
  String? json;
  int? id;
  UserProfile? user;
  int? eventTime;
  List<Pic>? pics;
  int? actId;
  List<BottomActivityInfo>? bottomActivityInfos;

  Event();

  factory Event.fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventToJson(this);
  }
}

@JsonSerializable()
class Pic {
  int? height;
  String? originUrl;
  String? squareUrl;
  String? rectangleUrl;
  int? width;
  String? format;

  Pic();

  factory Pic.fromJson(Map<String, dynamic> json) {
    return _$PicFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PicToJson(this);
  }
}

@JsonSerializable()
class BottomActivityInfo {
  String? id;
  int? type;
  String? name;
  String? target;
  bool? hot;

  BottomActivityInfo();

  factory BottomActivityInfo.fromJson(Map<String, dynamic> json) {
    return _$BottomActivityInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BottomActivityInfoToJson(this);
  }
}
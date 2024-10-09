import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'private_message.g.dart';

@JsonSerializable()
class PrivateMessage extends ServerStatusBean{
  int? newMsgCount;
  List<Msg>? msgs;

  PrivateMessage();

  factory PrivateMessage.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateMessageToJson(this);
}

@JsonSerializable()
class Msg {
  FromUser? fromUser;
  String? lastMsg;
  int? lastMsgTime;

  Msg();

  factory Msg.fromJson(Map<String, dynamic> json) =>
      _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}

@JsonSerializable()
class FromUser{
  String? nickname;
  String? detailDescription;
  String? avatarUrl;
  int? userType;
  int? userId;

  FromUser();

  factory FromUser.fromJson(Map<String, dynamic> json) =>
      _$FromUserFromJson(json);

  Map<String, dynamic> toJson() => _$FromUserToJson(this);
}
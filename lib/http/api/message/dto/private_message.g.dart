// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateMessage _$PrivateMessageFromJson(Map<String, dynamic> json) =>
    PrivateMessage()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..newMsgCount = (json['newMsgCount'] as num?)?.toInt()
      ..msgs = (json['msgs'] as List<dynamic>?)
          ?.map((e) => Msg.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PrivateMessageToJson(PrivateMessage instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'newMsgCount': instance.newMsgCount,
      'msgs': instance.msgs,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg()
  ..fromUser = json['fromUser'] == null
      ? null
      : FromUser.fromJson(json['fromUser'] as Map<String, dynamic>)
  ..lastMsg = json['lastMsg'] as String?
  ..lastMsgTime = (json['lastMsgTime'] as num?)?.toInt();

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'fromUser': instance.fromUser,
      'lastMsg': instance.lastMsg,
      'lastMsgTime': instance.lastMsgTime,
    };

FromUser _$FromUserFromJson(Map<String, dynamic> json) => FromUser()
  ..nickname = json['nickname'] as String?
  ..detailDescription = json['detailDescription'] as String?
  ..avatarUrl = json['avatarUrl'] as String?
  ..userType = (json['userType'] as num?)?.toInt()
  ..userId = (json['userId'] as num?)?.toInt();

Map<String, dynamic> _$FromUserToJson(FromUser instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'detailDescription': instance.detailDescription,
      'avatarUrl': instance.avatarUrl,
      'userType': instance.userType,
      'userId': instance.userId,
    };

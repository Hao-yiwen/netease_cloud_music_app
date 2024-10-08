import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'private_message.g.dart';

@JsonSerializable()
class PrivateMessage extends ServerStatusBean{
  int? newMsgCount;
}

@JsonSerializable()
class Msg {

}
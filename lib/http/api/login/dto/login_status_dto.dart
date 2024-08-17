import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/models/user/user_account.dart';
import 'package:netease_cloud_music_app/models/user/user_profile.dart';

part 'login_status_dto.g.dart';

@JsonSerializable()
class LoginStatusDto extends ServerStatusBean {
  UserAccount? account;
  UserProfile? profile;

  LoginStatusDto();

  factory LoginStatusDto.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStatusDtoToJson(this);
}

int dynamicToInt(dynamic value) {
  if (value is double) {
    return value.toInt();
  } else if (value is String) {
    return int.parse(value);
  }
  return value ?? 0;
}

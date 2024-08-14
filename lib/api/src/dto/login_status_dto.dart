import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/models/user/user_account.dart';
import 'package:netease_cloud_music_app/models/user/user_profile.dart';

part 'login_status_dto.g.dart';

@JsonSerializable()
class LoginStatusDto {
  final int code;
  final UserAccount? account;
  final UserProfile? profile;

  LoginStatusDto({required this.code, this.account, this.profile});

  factory LoginStatusDto.fromJson(Map<String, dynamic> json) => _$LoginStatusDtoFromJson(json);

}

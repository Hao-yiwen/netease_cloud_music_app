
import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  final int id;
  final String? userName;
  final int? type;
  final int? status;
  final int? createTime;
  final int? ban;
  final int? vipType;

  UserAccount(
      {required this.id,
      required this.userName,
      required this.type,
      required this.status,
      this.createTime,
      this.ban,
      this.vipType,});

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}

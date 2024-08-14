
import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  final int id;
  final String userName;
  final int type;
  final int status;
  final int? whitelistAuthority;
  final int? createTime;
  final int? tokenVersion;
  final int? ban;
  final int? baoyueVersion;
  final int? donateVersion;
  final int? vipType;
  final bool? anonimousUser;
  final bool? paidFee;

  UserAccount(
      {required this.id,
      required this.userName,
      required this.type,
      required this.status,
      this.whitelistAuthority,
      this.createTime,
      this.tokenVersion,
      this.ban,
      this.baoyueVersion,
      this.donateVersion,
      this.vipType,
      this.anonimousUser,
      this.paidFee});

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);
}

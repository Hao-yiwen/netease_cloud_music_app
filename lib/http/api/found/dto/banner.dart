import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner extends ServerStatusBean{
  List<BannerItem>? banners;

  Banner();

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}

@JsonSerializable()
class BannerItem {
  String? bannerId;
  String? pic;
  String? url;
  String? typeTitle;
  String? adDispatchJson;
  String? adurlV2;
  String? showContext;

  BannerItem();

  factory BannerItem.fromJson(Map<String, dynamic> json) => _$BannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';

part 'home_block.g.dart';

@JsonSerializable()
class HomeBlock extends ServerStatusBean {
  List<BlockItem>? blocks;

  HomeBlock();

  factory HomeBlock.fromJson(Map<String, dynamic> json) => _$HomeBlockFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockToJson(this);
}

@JsonSerializable()
class BlockItem {
  String? blockCode;
  String? showType;
  String? action;
  String? actionType;
  UIElement? uiElement;
  bool? canClose;
  List<Creative>? creatives;
  List<Ext>? extInfo;

  BlockItem();

  factory BlockItem.fromJson(Map<String, dynamic> json) => _$BlockItemFromJson(json);

  Map<String, dynamic> toJson() => _$BlockItemToJson(this);
}

@JsonSerializable()
class Ext{
  int? liveId;
  String? title;
  String? forceTitle;
  String? subTitle;
  String? forceSubTitle;
  String? cover;
  int? startTime;
  String? bgCoverUrl;
  String? verticalCover;

  Ext();

  factory Ext.fromJson(Map<String, dynamic> json) => _$ExtFromJson(json);

  Map<String, dynamic> toJson() => _$ExtToJson(this);
}

@JsonSerializable()
class Creative{
  String? creativeType;
  String? creativeId;
  String? action;
  String? actionType;
  UIElement? uiElement;
  String? logInfo;
  List<Resource>? resources;

  Creative();

  factory Creative.fromJson(Map<String, dynamic> json) => _$CreativeFromJson(json);

  Map<String, dynamic> toJson() => _$CreativeToJson(this);
}

@JsonSerializable()
class Resource {
  UIElement? uiElement;
  String? resourceType;
  String? resourceId;
  String? action;
  String? actionType;
  String? logInfo;

  Resource();

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

@JsonSerializable()
class UIElement {
  String? mainTitle;
  String? subTitle;
  Button? button;
  Image? image;
  String? labelTexts;

  UIElement();

  factory UIElement.fromJson(Map<String, dynamic> json) => _$UIElementFromJson(json);

  Map<String, dynamic> toJson() => _$UIElementToJson(this);
}

@JsonSerializable()
class Image {
  String? imageUrl;
  bool? purePicture;

  Image();

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Title{
  String? title;
  bool? canShowTitleLogo;

  Title();

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);

  Map<String, dynamic> toJson() => _$TitleToJson(this);
}

@JsonSerializable()
class Button{
  String? action;
  String? actionType;
  String? text;

  Button();

  factory Button.fromJson(Map<String, dynamic> json) => _$ButtonFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBlock _$HomeBlockFromJson(Map<String, dynamic> json) => HomeBlock()
  ..code = dynamicToInt(json['code'])
  ..message = json['message'] as String?
  ..msg = json['msg'] as String?
  ..blocks = (json['blocks'] as List<dynamic>?)
      ?.map((e) => BlockItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$HomeBlockToJson(HomeBlock instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'blocks': instance.blocks,
    };

BlockItem _$BlockItemFromJson(Map<String, dynamic> json) => BlockItem()
  ..blockCode = json['blockCode'] as String?
  ..showType = json['showType'] as String?
  ..action = json['action'] as String?
  ..actionType = json['actionType'] as String?
  ..uiElement = json['uiElement'] == null
      ? null
      : UIElement.fromJson(json['uiElement'] as Map<String, dynamic>)
  ..canClose = json['canClose'] as bool?
  ..creatives = (json['creatives'] as List<dynamic>?)
      ?.map((e) => Creative.fromJson(e as Map<String, dynamic>))
      .toList()
  ..extInfo = (json['extInfo'] as List<dynamic>?)
      ?.map((e) => Ext.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$BlockItemToJson(BlockItem instance) => <String, dynamic>{
      'blockCode': instance.blockCode,
      'showType': instance.showType,
      'action': instance.action,
      'actionType': instance.actionType,
      'uiElement': instance.uiElement,
      'canClose': instance.canClose,
      'creatives': instance.creatives,
      'extInfo': instance.extInfo,
    };

Ext _$ExtFromJson(Map<String, dynamic> json) => Ext()
  ..liveId = (json['liveId'] as num?)?.toInt()
  ..title = json['title'] as String?
  ..forceTitle = json['forceTitle'] as String?
  ..subTitle = json['subTitle'] as String?
  ..forceSubTitle = json['forceSubTitle'] as String?
  ..cover = json['cover'] as String?
  ..startTime = (json['startTime'] as num?)?.toInt()
  ..bgCoverUrl = json['bgCoverUrl'] as String?
  ..verticalCover = json['verticalCover'] as String?;

Map<String, dynamic> _$ExtToJson(Ext instance) => <String, dynamic>{
      'liveId': instance.liveId,
      'title': instance.title,
      'forceTitle': instance.forceTitle,
      'subTitle': instance.subTitle,
      'forceSubTitle': instance.forceSubTitle,
      'cover': instance.cover,
      'startTime': instance.startTime,
      'bgCoverUrl': instance.bgCoverUrl,
      'verticalCover': instance.verticalCover,
    };

Creative _$CreativeFromJson(Map<String, dynamic> json) => Creative()
  ..creativeType = json['creativeType'] as String?
  ..creativeId = json['creativeId'] as String?
  ..action = json['action'] as String?
  ..actionType = json['actionType'] as String?
  ..uiElement = json['uiElement'] == null
      ? null
      : UIElement.fromJson(json['uiElement'] as Map<String, dynamic>)
  ..logInfo = json['logInfo'] as String?
  ..resources = (json['resources'] as List<dynamic>?)
      ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$CreativeToJson(Creative instance) => <String, dynamic>{
      'creativeType': instance.creativeType,
      'creativeId': instance.creativeId,
      'action': instance.action,
      'actionType': instance.actionType,
      'uiElement': instance.uiElement,
      'logInfo': instance.logInfo,
      'resources': instance.resources,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource()
  ..uiElement = json['uiElement'] == null
      ? null
      : UIElement.fromJson(json['uiElement'] as Map<String, dynamic>)
  ..resourceType = json['resourceType'] as String?
  ..resourceId = json['resourceId'] as String?
  ..action = json['action'] as String?
  ..actionType = json['actionType'] as String?
  ..logInfo = json['logInfo'] as String?;

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'uiElement': instance.uiElement,
      'resourceType': instance.resourceType,
      'resourceId': instance.resourceId,
      'action': instance.action,
      'actionType': instance.actionType,
      'logInfo': instance.logInfo,
    };

UIElement _$UIElementFromJson(Map<String, dynamic> json) => UIElement()
  ..mainTitle = json['mainTitle'] as String?
  ..subTitle = json['subTitle'] as String?
  ..button = json['button'] == null
      ? null
      : Button.fromJson(json['button'] as Map<String, dynamic>)
  ..image = json['image'] == null
      ? null
      : Image.fromJson(json['image'] as Map<String, dynamic>)
  ..labelTexts = json['labelTexts'] as String?;

Map<String, dynamic> _$UIElementToJson(UIElement instance) => <String, dynamic>{
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'button': instance.button,
      'image': instance.image,
      'labelTexts': instance.labelTexts,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image()
  ..imageUrl = json['imageUrl'] as String?
  ..purePicture = json['purePicture'] as bool?;

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'purePicture': instance.purePicture,
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title()
  ..title = json['title'] as String?
  ..canShowTitleLogo = json['canShowTitleLogo'] as bool?;

Map<String, dynamic> _$TitleToJson(Title instance) => <String, dynamic>{
      'title': instance.title,
      'canShowTitleLogo': instance.canShowTitleLogo,
    };

Button _$ButtonFromJson(Map<String, dynamic> json) => Button()
  ..action = json['action'] as String?
  ..actionType = json['actionType'] as String?
  ..text = json['text'] as String?;

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
      'action': instance.action,
      'actionType': instance.actionType,
      'text': instance.text,
    };

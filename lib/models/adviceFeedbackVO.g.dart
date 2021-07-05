// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adviceFeedbackVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdviceFeedbackVO _$AdviceFeedbackVOFromJson(Map<String, dynamic> json) {
  return AdviceFeedbackVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..content = json['content'] as String
    ..images = json['images'] as String
    ..baseUrl = json['baseUrl'] as String
    ..bankUserId = json['bankUserId'] as int
    ..bankUserName = json['bankUserName'] as String
    ..bankUserPhone = json['bankUserPhone'] as String
    ..readStatus = json['readStatus'] as int
    ..readStatusText = json['readStatusText'] as String
    ..createTime = json['createTime'] as String;
}

Map<String, dynamic> _$AdviceFeedbackVOToJson(AdviceFeedbackVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'content': instance.content,
      'images': instance.images,
      'baseUrl': instance.baseUrl,
      'bankUserId': instance.bankUserId,
      'bankUserName': instance.bankUserName,
      'bankUserPhone': instance.bankUserPhone,
      'readStatus': instance.readStatus,
      'readStatusText': instance.readStatusText,
      'createTime': instance.createTime
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messageVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) {
  return MessageVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..cleanerName = json['cleanerName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as String
    ..images = json['images'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..readStatus = json['readStatus'] as int
    ..auditStatus = json['auditStatus'] as int
    ..id = json['id'] as int
    ..readStatusText = json['readStatusText'] as String
    ..subTitle = json['subTitle'] as String
    ..baseUrl = json['baseUrl'] as String
    ..title = json['title'] as String
    ..type = json['type'] as int
    ..days = json['days'] as int
    ..typeText = json['typeText'] as String;
}

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'cleanerName': instance.cleanerName,
      'content': instance.content,
      'createTime': instance.createTime,
      'images': instance.images,
      'organizationBranchName': instance.organizationBranchName,
      'readStatus': instance.readStatus,
      'auditStatus': instance.auditStatus,
      'id': instance.id,
      'readStatusText': instance.readStatusText,
      'subTitle': instance.subTitle,
      'baseUrl': instance.baseUrl,
      'title': instance.title,
      'type': instance.type,
      'days': instance.days,
      'typeText': instance.typeText
    };

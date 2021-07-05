// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergencyVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyVO _$EmergencyVOFromJson(Map<String, dynamic> json) {
  return EmergencyVO()
    ..cleanerName = json['cleanerName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as String
    ..id = json['id'] as int
    ..status = json['status'] as int
    ..images = json['images'] as String
    ..statusText = json['statusText'] as String
    ..baseUrl = json['baseUrl'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..resultContent = json['resultContent'] as String
    ..resultImages = json['resultImages'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$EmergencyVOToJson(EmergencyVO instance) =>
    <String, dynamic>{
      'cleanerName': instance.cleanerName,
      'content': instance.content,
      'createTime': instance.createTime,
      'id': instance.id,
      'status': instance.status,
      'images': instance.images,
      'statusText': instance.statusText,
      'baseUrl': instance.baseUrl,
      'organizationBranchName': instance.organizationBranchName,
      'resultContent': instance.resultContent,
      'resultImages': instance.resultImages,
      'title': instance.title
    };

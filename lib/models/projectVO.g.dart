// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectVO _$ProjectVOFromJson(Map<String, dynamic> json) {
  return ProjectVO()
    ..id = json['id'] as int
    ..createId = json['createId'] as int
    ..createName = json['createName'] as String
    ..createTime = json['createTime'] as String
    ..updateId = json['updateId'] as String
    ..updateName = json['updateName'] as String
    ..updateTime = json['updateTime'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..status = json['status'] as int
    ..type = json['type'] as int
    ..projectUserId = json['projectUserId'] as int
    ..projectUserName = json['projectUserName'] as String
    ..bankUserName = json['bankUserName'] as String
    ..bankUserId = json['bankUserId'] as int
    ..startDate = json['startDate'] as String
    ..endDate = json['endDate'] as String
    ..orgName = json['orgName'] as String
    ..deleteFlag = json['deleteFlag'] as int
    ..select = json['select'] as bool;
}

Map<String, dynamic> _$ProjectVOToJson(ProjectVO instance) => <String, dynamic>{
      'id': instance.id,
      'createId': instance.createId,
      'createName': instance.createName,
      'createTime': instance.createTime,
      'updateId': instance.updateId,
      'updateName': instance.updateName,
      'updateTime': instance.updateTime,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'type': instance.type,
      'projectUserId': instance.projectUserId,
      'projectUserName': instance.projectUserName,
      'bankUserName': instance.bankUserName,
      'bankUserId': instance.bankUserId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'orgName': instance.orgName,
      'deleteFlag': instance.deleteFlag,
      'select': instance.select
    };

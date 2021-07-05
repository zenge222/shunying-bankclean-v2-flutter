// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) {
  return UserVO()
    ..id = json['id'] as int
    ..token = json['token'] as String
    ..name = json['name'] as String
    ..phone = json['phone'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..type = json['type'] as int
    ..typeName = json['typeName'] as String
    ..idCardNo = json['idCardNo'] as String
    ..select = json['select'] as bool
    ..aveScore = (json['aveScore'] as num)?.toDouble()
    ..profile = json['profile'] as String
    ..taskName = json['taskName'] as String
    ..baseUrl = json['baseUrl'] as String
    ..taskId = json['taskId'] as int
    ..workStartTime = json['workStartTime'] as String
    ..workEndTime = json['workEndTime'] as String;
}

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'name': instance.name,
      'phone': instance.phone,
      'organizationBranchName': instance.organizationBranchName,
      'type': instance.type,
      'typeName': instance.typeName,
      'idCardNo': instance.idCardNo,
      'select': instance.select,
      'aveScore': instance.aveScore,
      'profile': instance.profile,
      'taskName': instance.taskName,
      'baseUrl': instance.baseUrl,
      'taskId': instance.taskId,
      'workStartTime': instance.workStartTime,
      'workEndTime': instance.workEndTime
    };

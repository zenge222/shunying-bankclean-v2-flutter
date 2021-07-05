// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleanerVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanerVO _$CleanerVOFromJson(Map<String, dynamic> json) {
  return CleanerVO()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..phone = json['phone'] as String
    ..profile = json['profile'] as String
    ..select = json['select'] as bool
    ..token = json['token'] as String
    ..type = json['type'] as int
    ..aveScore = json['aveScore'] as String
    ..workEndTime = json['workEndTime'] as String
    ..workStartTime = json['workStartTime'] as String
    ..idCardNo = json['idCardNo'] as String
    ..taskName = json['taskName'] as String
    ..taskId = json['taskId'] as int;
}

Map<String, dynamic> _$CleanerVOToJson(CleanerVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organizationBranchName': instance.organizationBranchName,
      'phone': instance.phone,
      'profile': instance.profile,
      'select': instance.select,
      'token': instance.token,
      'type': instance.type,
      'aveScore': instance.aveScore,
      'workEndTime': instance.workEndTime,
      'workStartTime': instance.workStartTime,
      'idCardNo': instance.idCardNo,
      'taskName': instance.taskName,
      'taskId': instance.taskId
    };

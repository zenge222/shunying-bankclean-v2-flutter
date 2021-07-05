// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskRequestVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRequestVO _$TaskRequestVOFromJson(Map<String, dynamic> json) {
  return TaskRequestVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..organizationBranId = json['organizationBranId'] as int
    ..startTime = json['startTime'] as String
    ..endTime = json['endTime'] as String
    ..duration = (json['duration'] as num)?.toDouble()
    ..workDate = json['workDate'] as String
    ..createTime = json['createTime'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String;
}

Map<String, dynamic> _$TaskRequestVOToJson(TaskRequestVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'organizationBranchName': instance.organizationBranchName,
      'organizationBranId': instance.organizationBranId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'duration': instance.duration,
      'workDate': instance.workDate,
      'createTime': instance.createTime,
      'status': instance.status,
      'statusText': instance.statusText
    };

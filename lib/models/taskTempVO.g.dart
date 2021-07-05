// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskTempVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskTempVO _$TaskTempVOFromJson(Map<String, dynamic> json) {
  return TaskTempVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..createTime = json['createTime'] as String
    ..endTime = json['endTime'] as String
    ..id = json['id'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..startTime = json['startTime'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$TaskTempVOToJson(TaskTempVO instance) =>
    <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'createTime': instance.createTime,
      'endTime': instance.endTime,
      'id': instance.id,
      'organizationBranchName': instance.organizationBranchName,
      'startTime': instance.startTime,
      'title': instance.title
    };

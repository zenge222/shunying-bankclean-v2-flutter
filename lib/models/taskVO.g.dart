// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskVO _$TaskVOFromJson(Map<String, dynamic> json) {
  return TaskVO()
    ..id = json['id'] as int
    ..cleanerId = json['cleanerId'] as int
    ..organizationBranchId = json['organizationBranchId'] as int
    ..title = json['title'] as String
    ..cleanerName = json['cleanerName'] as String
    ..cleanerPhone = json['cleanerPhone'] as String
    ..baseUrl = json['baseUrl'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..select = json['select'] as bool
    ..startTime = json['startTime'] as String
    ..createTime = json['createTime'] as String
    ..areaManagerName = json['areaManagerName'] as String
    ..workDate = json['workDate'] as String
    ..endTime = json['endTime'] as String
    ..cleanerProfile = json['cleanerProfile'] as String
    ..taskItemVOList = (json['taskItemVOList'] as List)
        ?.map((e) =>
            e == null ? null : TaskItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TaskVOToJson(TaskVO instance) => <String, dynamic>{
      'id': instance.id,
      'cleanerId': instance.cleanerId,
      'organizationBranchId': instance.organizationBranchId,
      'title': instance.title,
      'cleanerName': instance.cleanerName,
      'cleanerPhone': instance.cleanerPhone,
      'baseUrl': instance.baseUrl,
      'organizationBranchName': instance.organizationBranchName,
      'select': instance.select,
      'startTime': instance.startTime,
      'createTime': instance.createTime,
      'areaManagerName': instance.areaManagerName,
      'workDate': instance.workDate,
      'endTime': instance.endTime,
      'cleanerProfile': instance.cleanerProfile,
      'taskItemVOList': instance.taskItemVOList
    };

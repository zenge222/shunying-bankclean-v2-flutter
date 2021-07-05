// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workOffApplyVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOffApplyVO _$WorkOffApplyVOFromJson(Map<String, dynamic> json) {
  return WorkOffApplyVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..cleanerName = json['cleanerName'] as String
    ..createTime = json['createTime'] as String
    ..endDate = json['endDate'] as String
    ..endTime = json['endTime'] as int
    ..endTimeText = json['endTimeText'] as String
    ..id = json['id'] as int
    ..insteadCleanerName = json['insteadCleanerName'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..reason = json['reason'] as String
    ..startDate = json['startDate'] as String
    ..startTime = json['startTime'] as int
    ..startTimeText = json['startTimeText'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..title = json['title'] as String
    ..type = json['type'] as int
    ..typeText = json['typeText'] as String;
}

Map<String, dynamic> _$WorkOffApplyVOToJson(WorkOffApplyVO instance) =>
    <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'cleanerName': instance.cleanerName,
      'createTime': instance.createTime,
      'endDate': instance.endDate,
      'endTime': instance.endTime,
      'endTimeText': instance.endTimeText,
      'id': instance.id,
      'insteadCleanerName': instance.insteadCleanerName,
      'organizationBranchName': instance.organizationBranchName,
      'reason': instance.reason,
      'startDate': instance.startDate,
      'startTime': instance.startTime,
      'startTimeText': instance.startTimeText,
      'status': instance.status,
      'statusText': instance.statusText,
      'title': instance.title,
      'type': instance.type,
      'typeText': instance.typeText
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propertyCheckRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyCheckRecordVO _$PropertyCheckRecordVOFromJson(
    Map<String, dynamic> json) {
  return PropertyCheckRecordVO()
    ..id = json['id'] as int
    ..createTime = json['createTime'] as String
    ..itemVOList = (json['itemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : PropertyCheckRecordItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..managerId = json['managerId'] as int
    ..managerName = json['managerName'] as String
    ..organizationBranchId = json['organizationBranchId'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectId = json['projectId'] as int
    ..projectName = json['projectName'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String;
}

Map<String, dynamic> _$PropertyCheckRecordVOToJson(
        PropertyCheckRecordVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'itemVOList': instance.itemVOList,
      'managerId': instance.managerId,
      'managerName': instance.managerName,
      'organizationBranchId': instance.organizationBranchId,
      'organizationBranchName': instance.organizationBranchName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'status': instance.status,
      'statusText': instance.statusText
    };

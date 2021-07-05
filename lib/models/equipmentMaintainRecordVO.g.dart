// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipmentMaintainRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentMaintainRecordVO _$EquipmentMaintainRecordVOFromJson(
    Map<String, dynamic> json) {
  return EquipmentMaintainRecordVO()
    ..id = json['id'] as int
    ..checkEmployeeName = json['checkEmployeeName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as String
    ..organizationBranchId = json['organizationBranchId'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectId = json['projectId'] as int
    ..projectName = json['projectName'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$EquipmentMaintainRecordVOToJson(
        EquipmentMaintainRecordVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkEmployeeName': instance.checkEmployeeName,
      'content': instance.content,
      'createTime': instance.createTime,
      'organizationBranchId': instance.organizationBranchId,
      'organizationBranchName': instance.organizationBranchName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'title': instance.title
    };

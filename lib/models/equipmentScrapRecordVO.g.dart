// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipmentScrapRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentScrapRecordVO _$EquipmentScrapRecordVOFromJson(
    Map<String, dynamic> json) {
  return EquipmentScrapRecordVO()
    ..id = json['id'] as int
    ..baseUrl = json['baseUrl'] as String
    ..checkName = json['checkName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as String
    ..equipmentId = json['equipmentId'] as int
    ..equipmentImg = json['equipmentImg'] as String
    ..equipmentName = json['equipmentName'] as String
    ..equipmentNo = json['equipmentNo'] as String
    ..equipmentType = json['equipmentType'] as int
    ..img = json['img'] as String
    ..organizationBranchId = json['organizationBranchId'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectId = json['projectId'] as int
    ..projectName = json['projectName'] as String
    ..repairEmployeeId = json['repairEmployeeId'] as int
    ..repairEmployeeName = json['repairEmployeeName'] as String
    ..status = json['status'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$EquipmentScrapRecordVOToJson(
        EquipmentScrapRecordVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'baseUrl': instance.baseUrl,
      'checkName': instance.checkName,
      'content': instance.content,
      'createTime': instance.createTime,
      'equipmentId': instance.equipmentId,
      'equipmentImg': instance.equipmentImg,
      'equipmentName': instance.equipmentName,
      'equipmentNo': instance.equipmentNo,
      'equipmentType': instance.equipmentType,
      'img': instance.img,
      'organizationBranchId': instance.organizationBranchId,
      'organizationBranchName': instance.organizationBranchName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'repairEmployeeId': instance.repairEmployeeId,
      'repairEmployeeName': instance.repairEmployeeName,
      'status': instance.status,
      'title': instance.title
    };

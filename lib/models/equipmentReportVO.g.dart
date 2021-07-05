// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipmentReportVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentReportVO _$EquipmentReportVOFromJson(Map<String, dynamic> json) {
  return EquipmentReportVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..address = json['address'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..equipmentImg = json['equipmentImg'] as String
    ..baseUrl = json['baseUrl'] as String
    ..equipmentName = json['equipmentName'] as String
    ..equipmentNo = json['equipmentNo'] as String
    ..equipmentType = json['equipmentType'] as int
    ..equipmentId = json['equipmentId'] as int
    ..equipmentTypeText = json['equipmentTypeText'] as String
    ..reportImg = json['reportImg'] as String
    ..reportContent = json['reportContent'] as String
    ..repairEmployeeName = json['repairEmployeeName'] as String
    ..repairDate = json['repairDate'] as String
    ..managerResultImg = json['managerResultImg'] as String
    ..managerResultContent = json['managerResultContent'] as String
    ..repairResultImg = json['repairResultImg'] as String
    ..repairResultContent = json['repairResultContent'] as String
    ..cleanerName = json['cleanerName'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectName = json['projectName'] as String
    ..createTime = json['createTime'] as String;
}

Map<String, dynamic> _$EquipmentReportVOToJson(EquipmentReportVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'status': instance.status,
      'statusText': instance.statusText,
      'equipmentImg': instance.equipmentImg,
      'baseUrl': instance.baseUrl,
      'equipmentName': instance.equipmentName,
      'equipmentNo': instance.equipmentNo,
      'equipmentType': instance.equipmentType,
      'equipmentId': instance.equipmentId,
      'equipmentTypeText': instance.equipmentTypeText,
      'reportImg': instance.reportImg,
      'reportContent': instance.reportContent,
      'repairEmployeeName': instance.repairEmployeeName,
      'repairDate': instance.repairDate,
      'managerResultImg': instance.managerResultImg,
      'managerResultContent': instance.managerResultContent,
      'repairResultImg': instance.repairResultImg,
      'repairResultContent': instance.repairResultContent,
      'cleanerName': instance.cleanerName,
      'organizationBranchName': instance.organizationBranchName,
      'projectName': instance.projectName,
      'createTime': instance.createTime
    };

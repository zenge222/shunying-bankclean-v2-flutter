// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipmentVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentVO _$EquipmentVOFromJson(Map<String, dynamic> json) {
  return EquipmentVO()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..img = json['img'] as String
    ..baseUrl = json['baseUrl'] as String
    ..no = json['no'] as String
    ..sku = json['sku'] as String
    ..address = json['address'] as String
    ..type = json['type'] as int
    ..typeText = json['typeText'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..buyDate = json['buyDate'] as String
    ..qualityDate = json['qualityDate'] as String
    ..checkCycle = json['checkCycle'] as String
    ..dutyPerson = json['dutyPerson'] as String
    ..dutyPersonId = json['dutyPersonId'] as int
    ..businessName = json['businessName'] as String
    ..businessContactPhone = json['businessContactPhone'] as String
    ..organizationBranchId = json['organizationBranchId'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectName = json['projectName'] as String
    ..projectId = json['projectId'] as int
    ..deleteFlag = json['deleteFlag'] as int
    ..createTime = json['createTime'] as String
    ..recordVOList = (json['recordVOList'] as List)
        ?.map((e) => e == null
            ? null
            : EquipmentRepairRecordVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EquipmentVOToJson(EquipmentVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'baseUrl': instance.baseUrl,
      'no': instance.no,
      'sku': instance.sku,
      'address': instance.address,
      'type': instance.type,
      'typeText': instance.typeText,
      'status': instance.status,
      'statusText': instance.statusText,
      'buyDate': instance.buyDate,
      'qualityDate': instance.qualityDate,
      'checkCycle': instance.checkCycle,
      'dutyPerson': instance.dutyPerson,
      'dutyPersonId': instance.dutyPersonId,
      'businessName': instance.businessName,
      'businessContactPhone': instance.businessContactPhone,
      'organizationBranchId': instance.organizationBranchId,
      'organizationBranchName': instance.organizationBranchName,
      'projectName': instance.projectName,
      'projectId': instance.projectId,
      'deleteFlag': instance.deleteFlag,
      'createTime': instance.createTime,
      'recordVOList': instance.recordVOList
    };

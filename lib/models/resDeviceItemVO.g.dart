// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resDeviceItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResDeviceItemVO _$ResDeviceItemVOFromJson(Map<String, dynamic> json) {
  return ResDeviceItemVO()
    ..baseUrl = json['baseUrl'] as String
    ..businessContactPhone = json['businessContactPhone'] as String
    ..businessName = json['businessName'] as String
    ..buyDate = json['buyDate'] as String
    ..checkCycle = json['checkCycle'] as String
    ..createTime = json['createTime'] as String
    ..deleteFlag = json['deleteFlag'] as int
    ..dutyPerson = json['dutyPerson'] as String
    ..dutyPersonId = json['dutyPersonId'] as String
    ..id = json['id'] as String
    ..img = json['img'] as String
    ..name = json['name'] as String
    ..no = json['no'] as String
    ..organizationBranchId = json['organizationBranchId'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..projectId = json['projectId'] as String
    ..projectName = json['projectName'] as String
    ..qualityDate = json['qualityDate'] as String
    ..sku = json['sku'] as String
    ..status = json['status'] as int
    ..type = json['type'] as int;
}

Map<String, dynamic> _$ResDeviceItemVOToJson(ResDeviceItemVO instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'businessContactPhone': instance.businessContactPhone,
      'businessName': instance.businessName,
      'buyDate': instance.buyDate,
      'checkCycle': instance.checkCycle,
      'createTime': instance.createTime,
      'deleteFlag': instance.deleteFlag,
      'dutyPerson': instance.dutyPerson,
      'dutyPersonId': instance.dutyPersonId,
      'id': instance.id,
      'img': instance.img,
      'name': instance.name,
      'no': instance.no,
      'organizationBranchId': instance.organizationBranchId,
      'organizationBranchName': instance.organizationBranchName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'qualityDate': instance.qualityDate,
      'sku': instance.sku,
      'status': instance.status,
      'type': instance.type
    };

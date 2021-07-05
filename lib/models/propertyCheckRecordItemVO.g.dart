// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propertyCheckRecordItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyCheckRecordItemVO _$PropertyCheckRecordItemVOFromJson(
    Map<String, dynamic> json) {
  return PropertyCheckRecordItemVO()
    ..equipmentId = json['equipmentId'] as int
    ..equipmentBuyDate = json['equipmentBuyDate'] as String
    ..equipmentDutyPerson = json['equipmentDutyPerson'] as String
    ..equipmentName = json['equipmentName'] as String
    ..equipmentNo = json['equipmentNo'] as String
    ..equipmentSku = json['equipmentSku'] as String
    ..equipmentType = json['equipmentType'] as int
    ..id = json['id'] as int
    ..status = json['status'] as int;
}

Map<String, dynamic> _$PropertyCheckRecordItemVOToJson(
        PropertyCheckRecordItemVO instance) =>
    <String, dynamic>{
      'equipmentId': instance.equipmentId,
      'equipmentBuyDate': instance.equipmentBuyDate,
      'equipmentDutyPerson': instance.equipmentDutyPerson,
      'equipmentName': instance.equipmentName,
      'equipmentNo': instance.equipmentNo,
      'equipmentSku': instance.equipmentSku,
      'equipmentType': instance.equipmentType,
      'id': instance.id,
      'status': instance.status
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipmentRepairRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentRepairRecordVO _$EquipmentRepairRecordVOFromJson(
    Map<String, dynamic> json) {
  return EquipmentRepairRecordVO()
    ..equipmentId = json['equipmentId'] as int
    ..repairEmployeeName = json['repairEmployeeName'] as String
    ..content = json['content'] as String
    ..img = json['img'] as String
    ..createTime = json['createTime'] as String
    ..open = json['open'] as bool;
}

Map<String, dynamic> _$EquipmentRepairRecordVOToJson(
        EquipmentRepairRecordVO instance) =>
    <String, dynamic>{
      'equipmentId': instance.equipmentId,
      'repairEmployeeName': instance.repairEmployeeName,
      'content': instance.content,
      'img': instance.img,
      'createTime': instance.createTime,
      'open': instance.open
    };

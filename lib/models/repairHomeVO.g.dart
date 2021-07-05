// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repairHomeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairHomeVO _$RepairHomeVOFromJson(Map<String, dynamic> json) {
  return RepairHomeVO()
    ..needCount = json['needCount'] as int
    ..repairedCount = json['repairedCount'] as int
    ..todayCount = json['todayCount'] as int;
}

Map<String, dynamic> _$RepairHomeVOToJson(RepairHomeVO instance) =>
    <String, dynamic>{
      'needCount': instance.needCount,
      'repairedCount': instance.repairedCount,
      'todayCount': instance.todayCount
    };

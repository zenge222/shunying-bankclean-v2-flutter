// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areaVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaVO _$AreaVOFromJson(Map<String, dynamic> json) {
  return AreaVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..orgBranchCount = json['orgBranchCount'] as int
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String;
}

Map<String, dynamic> _$AreaVOToJson(AreaVO instance) => <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'id': instance.id,
      'name': instance.name,
      'orgBranchCount': instance.orgBranchCount,
      'status': instance.status,
      'statusText': instance.statusText
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectHomeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectHomeVO _$ProjectHomeVOFromJson(Map<String, dynamic> json) {
  return ProjectHomeVO()
    ..orgBranchUnAllocationCount = json['orgBranchUnAllocationCount'] as int
    ..toolsUnCheckCount = json['toolsUnCheckCount'] as int;
}

Map<String, dynamic> _$ProjectHomeVOToJson(ProjectHomeVO instance) =>
    <String, dynamic>{
      'orgBranchUnAllocationCount': instance.orgBranchUnAllocationCount,
      'toolsUnCheckCount': instance.toolsUnCheckCount
    };

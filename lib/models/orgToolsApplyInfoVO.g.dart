// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgToolsApplyInfoVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgToolsApplyInfoVO _$OrgToolsApplyInfoVOFromJson(Map<String, dynamic> json) {
  return OrgToolsApplyInfoVO()
    ..orgBranchName = json['orgBranchName'] as String
    ..orgBranchImage = json['orgBranchImage'] as String
    ..overBudget = json['overBudget'] as int
    ..overBudgetText = json['overBudgetText'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..applyCleanerNames = json['applyCleanerNames'] as String
    ..sumQuantity = json['sumQuantity'] as int
    ..orgBranchId = json['orgBranchId'] as int
    ..applyVOList = (json['applyVOList'] as List)
        ?.map((e) =>
            e == null ? null : ToolsApplyVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemVOList = (json['itemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : ToolsApplyItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrgToolsApplyInfoVOToJson(
        OrgToolsApplyInfoVO instance) =>
    <String, dynamic>{
      'orgBranchName': instance.orgBranchName,
      'orgBranchImage': instance.orgBranchImage,
      'overBudget': instance.overBudget,
      'overBudgetText': instance.overBudgetText,
      'status': instance.status,
      'statusText': instance.statusText,
      'applyCleanerNames': instance.applyCleanerNames,
      'sumQuantity': instance.sumQuantity,
      'orgBranchId': instance.orgBranchId,
      'applyVOList': instance.applyVOList,
      'itemVOList': instance.itemVOList
    };

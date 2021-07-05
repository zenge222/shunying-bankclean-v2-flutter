// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolsApplyVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolsApplyVO _$ToolsApplyVOFromJson(Map<String, dynamic> json) {
  return ToolsApplyVO()
    ..cleanerName = json['cleanerName'] as String
    ..createTime = json['createTime'] as String
    ..id = json['id'] as int
    ..mark = json['mark'] as String
    ..materialApplyItemVOList = (json['materialApplyItemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : ToolsApplyItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..organizationBranchName = json['organizationBranchName'] as String
    ..reason = json['reason'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$ToolsApplyVOToJson(ToolsApplyVO instance) =>
    <String, dynamic>{
      'cleanerName': instance.cleanerName,
      'createTime': instance.createTime,
      'id': instance.id,
      'mark': instance.mark,
      'materialApplyItemVOList': instance.materialApplyItemVOList,
      'organizationBranchName': instance.organizationBranchName,
      'reason': instance.reason,
      'status': instance.status,
      'statusText': instance.statusText,
      'title': instance.title
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexTaskInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexTaskInfo _$IndexTaskInfoFromJson(Map<String, dynamic> json) {
  return IndexTaskInfo()
    ..orgBranchVOList = (json['orgBranchVOList'] as List)
        ?.map((e) =>
            e == null ? null : OrgBranchVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..taskVOList = (json['taskVOList'] as List)
        ?.map((e) =>
            e == null ? null : TaskVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IndexTaskInfoToJson(IndexTaskInfo instance) =>
    <String, dynamic>{
      'orgBranchVOList': instance.orgBranchVOList,
      'taskVOList': instance.taskVOList
    };

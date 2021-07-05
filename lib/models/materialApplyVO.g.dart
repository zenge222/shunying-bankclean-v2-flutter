// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materialApplyVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialApplyVO _$MaterialApplyVOFromJson(Map<String, dynamic> json) {
  return MaterialApplyVO()
    ..cleanerName = json['cleanerName'] as String
    ..createTime = json['createTime'] as String
    ..mark = json['mark'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..reason = json['reason'] as String
    ..id = json['id'] as int
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..title = json['title'] as String
    ..materialApplyItemVOList = (json['materialApplyItemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : MaterialApplyItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MaterialApplyVOToJson(MaterialApplyVO instance) =>
    <String, dynamic>{
      'cleanerName': instance.cleanerName,
      'createTime': instance.createTime,
      'mark': instance.mark,
      'organizationBranchName': instance.organizationBranchName,
      'reason': instance.reason,
      'id': instance.id,
      'status': instance.status,
      'statusText': instance.statusText,
      'title': instance.title,
      'materialApplyItemVOList': instance.materialApplyItemVOList
    };

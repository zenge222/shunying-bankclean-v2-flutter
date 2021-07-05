// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchAssessRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAssessRecordVO _$BranchAssessRecordVOFromJson(Map<String, dynamic> json) {
  return BranchAssessRecordVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..month = json['month'] as int
    ..year = json['year'] as int
    ..organizationBranchName = json['organizationBranchName'] as String
    ..organizationBranchId = json['organizationBranchId'] as int
    ..bankUserId = json['bankUserId'] as int
    ..subTitle = json['subTitle'] as String
    ..aveScore = (json['aveScore'] as num)?.toDouble()
    ..createTime = json['createTime'] as String
    ..itemVOList = (json['itemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : BranchAssessRecordItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BranchAssessRecordVOToJson(
        BranchAssessRecordVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'month': instance.month,
      'year': instance.year,
      'organizationBranchName': instance.organizationBranchName,
      'organizationBranchId': instance.organizationBranchId,
      'bankUserId': instance.bankUserId,
      'subTitle': instance.subTitle,
      'aveScore': instance.aveScore,
      'createTime': instance.createTime,
      'itemVOList': instance.itemVOList
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areaLeaderAssessVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaLeaderAssessVO _$AreaLeaderAssessVOFromJson(Map<String, dynamic> json) {
  return AreaLeaderAssessVO()
    ..profile = json['profile'] as String
    ..baseUrl = json['baseUrl'] as String
    ..name = json['name'] as String
    ..phone = json['phone'] as String
    ..orgBranchCount = json['orgBranchCount'] as int
    ..orgCheckCount = json['orgCheckCount'] as int
    ..aveScore = (json['aveScore'] as num)?.toDouble()
    ..feedbackCount = json['feedbackCount'] as int
    ..satisfyingCount = json['satisfyingCount'] as int
    ..general = json['general'] as int
    ..unSatisfying = json['unSatisfying'] as int
    ..onTime = json['onTime'] as int
    ..outTime = json['outTime'] as int
    ..branchAssessRecordVOList = (json['branchAssessRecordVOList'] as List)
        ?.map((e) => e == null
            ? null
            : BranchAssessRecordVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AreaLeaderAssessVOToJson(AreaLeaderAssessVO instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'baseUrl': instance.baseUrl,
      'name': instance.name,
      'phone': instance.phone,
      'orgBranchCount': instance.orgBranchCount,
      'orgCheckCount': instance.orgCheckCount,
      'aveScore': instance.aveScore,
      'feedbackCount': instance.feedbackCount,
      'satisfyingCount': instance.satisfyingCount,
      'general': instance.general,
      'unSatisfying': instance.unSatisfying,
      'onTime': instance.onTime,
      'outTime': instance.outTime,
      'branchAssessRecordVOList': instance.branchAssessRecordVOList
    };

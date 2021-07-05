// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgCheckInfoVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCheckInfoVO _$OrgCheckInfoVOFromJson(Map<String, dynamic> json) {
  return OrgCheckInfoVO()
    ..orgBranchName = json['orgBranchName'] as String
    ..address = json['address'] as String
    ..aveScore = (json['aveScore'] as num)?.toDouble()
    ..subTitle = json['subTitle'] as String
    ..orgCheckRecordCount = json['orgCheckRecordCount'] as int
    ..feedbackCount = json['feedbackCount'] as int
    ..finishTaskCount = json['finishTaskCount'] as int
    ..unFinishTaskCount = json['unFinishTaskCount'] as int
    ..onTime = json['onTime'] as int
    ..outTime = json['outTime'] as int
    ..userList = (json['userList'] as List)
        ?.map((e) =>
            e == null ? null : UserVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..taskItemVOList = (json['taskItemVOList'] as List)
        ?.map((e) =>
            e == null ? null : TaskItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrgCheckInfoVOToJson(OrgCheckInfoVO instance) =>
    <String, dynamic>{
      'orgBranchName': instance.orgBranchName,
      'address': instance.address,
      'aveScore': instance.aveScore,
      'subTitle': instance.subTitle,
      'orgCheckRecordCount': instance.orgCheckRecordCount,
      'feedbackCount': instance.feedbackCount,
      'finishTaskCount': instance.finishTaskCount,
      'unFinishTaskCount': instance.unFinishTaskCount,
      'onTime': instance.onTime,
      'outTime': instance.outTime,
      'userList': instance.userList,
      'taskItemVOList': instance.taskItemVOList
    };

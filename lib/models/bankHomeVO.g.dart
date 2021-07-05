// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankHomeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankHomeVO _$BankHomeVOFromJson(Map<String, dynamic> json) {
  return BankHomeVO()
    ..image = json['image'] as String
    ..orgBranchName = json['orgBranchName'] as String
    ..baseUrl = json['baseUrl'] as String
    ..taskItemRecordCount = json['taskItemRecordCount'] as int
    ..orgBranchId = json['orgBranchId'] as int
    ..allTaskItemRecordCount = json['allTaskItemRecordCount'] as int
    ..feedbackCount = json['feedbackCount'] as int
    ..allFeedbackCount = json['allFeedbackCount'] as int
    ..taskItemVOList = (json['taskItemVOList'] as List)
        ?.map((e) =>
            e == null ? null : TaskItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BankHomeVOToJson(BankHomeVO instance) =>
    <String, dynamic>{
      'image': instance.image,
      'orgBranchName': instance.orgBranchName,
      'baseUrl': instance.baseUrl,
      'taskItemRecordCount': instance.taskItemRecordCount,
      'orgBranchId': instance.orgBranchId,
      'allTaskItemRecordCount': instance.allTaskItemRecordCount,
      'feedbackCount': instance.feedbackCount,
      'allFeedbackCount': instance.allFeedbackCount,
      'taskItemVOList': instance.taskItemVOList
    };

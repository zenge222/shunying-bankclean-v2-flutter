// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areaManagerHomeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaManagerHomeVO _$AreaManagerHomeVOFromJson(Map<String, dynamic> json) {
  return AreaManagerHomeVO()
    ..taskRequestCount = json['taskRequestCount'] as int
    ..workOffApplyCount = json['workOffApplyCount'] as int
    ..feedbackCount = json['feedbackCount'] as int
    ..messageCount = json['messageCount'] as int
    ..later = json['later'] as int
    ..early = json['early'] as int
    ..lack = json['lack'] as int
    ..workOffCount = json['workOffCount'] as int
    ..absenteeism = json['absenteeism'] as int
    ..finishTaskCount = json['finishTaskCount'] as int
    ..allTaskCount = json['allTaskCount'] as int
    ..finishFeedbackCount = json['finishFeedbackCount'] as int
    ..allFeedbackCount = json['allFeedbackCount'] as int
    ..attendanceCount = json['attendanceCount'] as int
    ..allAttendanceCount = json['allAttendanceCount'] as int
    ..toolsCheck = json['toolsCheck'] as bool
    ..attendanceVOList = (json['attendanceVOList'] as List)
        ?.map((e) => e == null
            ? null
            : CleanerAttendanceVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AreaManagerHomeVOToJson(AreaManagerHomeVO instance) =>
    <String, dynamic>{
      'taskRequestCount': instance.taskRequestCount,
      'workOffApplyCount': instance.workOffApplyCount,
      'feedbackCount': instance.feedbackCount,
      'messageCount': instance.messageCount,
      'later': instance.later,
      'early': instance.early,
      'lack': instance.lack,
      'workOffCount': instance.workOffCount,
      'absenteeism': instance.absenteeism,
      'finishTaskCount': instance.finishTaskCount,
      'allTaskCount': instance.allTaskCount,
      'finishFeedbackCount': instance.finishFeedbackCount,
      'allFeedbackCount': instance.allFeedbackCount,
      'attendanceCount': instance.attendanceCount,
      'allAttendanceCount': instance.allAttendanceCount,
      'toolsCheck': instance.toolsCheck,
      'attendanceVOList': instance.attendanceVOList
    };

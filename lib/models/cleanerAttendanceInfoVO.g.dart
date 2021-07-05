// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleanerAttendanceInfoVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanerAttendanceInfoVO _$CleanerAttendanceInfoVOFromJson(
    Map<String, dynamic> json) {
  return CleanerAttendanceInfoVO()
    ..profile = json['profile'] as String
    ..cleanerName = json['cleanerName'] as String
    ..orgBranchName = json['orgBranchName'] as String
    ..phone = json['phone'] as String
    ..startWorkTime = json['startWorkTime'] as String
    ..endWorkTime = json['endWorkTime'] as String
    ..baseUrl = json['baseUrl'] as String
    ..accessScore = (json['accessScore'] as num)?.toDouble()
    ..feedbackCount = json['feedbackCount'] as int
    ..taskFinish = json['taskFinish'] as int
    ..taskUnFinish = json['taskUnFinish'] as int
    ..onTime = json['onTime'] as int
    ..outTime = json['outTime'] as int
    ..workDayCount = json['workDayCount'] as int
    ..workTimeCount = (json['workTimeCount'] as num)?.toDouble()
    ..workOffCount = json['workOffCount'] as int
    ..later = json['later'] as int
    ..early = json['early'] as int
    ..lack = json['lack'] as int
    ..absenteeism = json['absenteeism'] as int
    ..attendanceVOList = (json['attendanceVOList'] as List)
        ?.map((e) => e == null
            ? null
            : CleanerAttendanceVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cleanerAssessRecordItemVOList =
        (json['cleanerAssessRecordItemVOList'] as List)
            ?.map((e) => e == null
                ? null
                : CleanerAssessRecordItemVO.fromJson(e as Map<String, dynamic>))
            ?.toList();
}

Map<String, dynamic> _$CleanerAttendanceInfoVOToJson(
        CleanerAttendanceInfoVO instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'cleanerName': instance.cleanerName,
      'orgBranchName': instance.orgBranchName,
      'phone': instance.phone,
      'startWorkTime': instance.startWorkTime,
      'endWorkTime': instance.endWorkTime,
      'baseUrl': instance.baseUrl,
      'accessScore': instance.accessScore,
      'feedbackCount': instance.feedbackCount,
      'taskFinish': instance.taskFinish,
      'taskUnFinish': instance.taskUnFinish,
      'onTime': instance.onTime,
      'outTime': instance.outTime,
      'workDayCount': instance.workDayCount,
      'workTimeCount': instance.workTimeCount,
      'workOffCount': instance.workOffCount,
      'later': instance.later,
      'early': instance.early,
      'lack': instance.lack,
      'absenteeism': instance.absenteeism,
      'attendanceVOList': instance.attendanceVOList,
      'cleanerAssessRecordItemVOList': instance.cleanerAssessRecordItemVOList
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleanerAttendanceVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanerAttendanceVO _$CleanerAttendanceVOFromJson(Map<String, dynamic> json) {
  return CleanerAttendanceVO()
    ..cleanerName = json['cleanerName'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..createTime = json['createTime'] as String
    ..firstTime = json['firstTime'] as String
    ..secondTime = json['secondTime'] as String
    ..firstStatus = json['firstStatus'] as int
    ..firstStatusText = json['firstStatusText'] as String
    ..secondStatus = json['secondStatus'] as int
    ..secondStatusText = json['secondStatusText'] as String;
}

Map<String, dynamic> _$CleanerAttendanceVOToJson(
        CleanerAttendanceVO instance) =>
    <String, dynamic>{
      'cleanerName': instance.cleanerName,
      'organizationBranchName': instance.organizationBranchName,
      'createTime': instance.createTime,
      'firstTime': instance.firstTime,
      'secondTime': instance.secondTime,
      'firstStatus': instance.firstStatus,
      'firstStatusText': instance.firstStatusText,
      'secondStatus': instance.secondStatus,
      'secondStatusText': instance.secondStatusText
    };

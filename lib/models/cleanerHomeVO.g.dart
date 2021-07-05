// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleanerHomeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanerHomeVO _$CleanerHomeVOFromJson(Map<String, dynamic> json) {
  return CleanerHomeVO()
    ..orgBranchName = json['orgBranchName'] as String
    ..orgImage = json['orgImage'] as String
    ..baseUrl = json['baseUrl'] as String
    ..feedbackCount = json['feedbackCount'] as int
    ..todayHaveWork = json['todayHaveWork'] as int
    ..tomorrowWork = json['tomorrowWork'] as int
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..todayTitle = json['todayTitle'] as String
    ..todayAddress = json['todayAddress'] as String
    ..todayStartWorkTime = json['todayStartWorkTime'] as String
    ..todayEndWorkTime = json['todayEndWorkTime'] as String
    ..tomorrowTitle = json['tomorrowTitle'] as String
    ..tomorrowAddress = json['tomorrowAddress'] as String
    ..tomorrowStartWorkTime = json['tomorrowStartWorkTime'] as String
    ..tomorrowEndWorkTime = json['tomorrowEndWorkTime'] as String
    ..taskItemVOList = (json['taskItemVOList'] as List)
        ?.map((e) =>
            e == null ? null : TaskItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CleanerHomeVOToJson(CleanerHomeVO instance) =>
    <String, dynamic>{
      'orgBranchName': instance.orgBranchName,
      'orgImage': instance.orgImage,
      'baseUrl': instance.baseUrl,
      'feedbackCount': instance.feedbackCount,
      'todayHaveWork': instance.todayHaveWork,
      'tomorrowWork': instance.tomorrowWork,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'todayTitle': instance.todayTitle,
      'todayAddress': instance.todayAddress,
      'todayStartWorkTime': instance.todayStartWorkTime,
      'todayEndWorkTime': instance.todayEndWorkTime,
      'tomorrowTitle': instance.tomorrowTitle,
      'tomorrowAddress': instance.tomorrowAddress,
      'tomorrowStartWorkTime': instance.tomorrowStartWorkTime,
      'tomorrowEndWorkTime': instance.tomorrowEndWorkTime,
      'taskItemVOList': instance.taskItemVOList
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedbackVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackVO _$FeedbackVOFromJson(Map<String, dynamic> json) {
  return FeedbackVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..cleanerName = json['cleanerName'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] as String
    ..dispatchTime = json['dispatchTime'] as String
    ..id = json['id'] as int
    ..areaLeaderTimeout = json['areaLeaderTimeout'] as int
    ..areaLeaderTimeoutText = json['areaLeaderTimeoutText'] as String
    ..cleanerTimeout = json['cleanerTimeout'] as int
    ..cleanerTimeoutText = json['cleanerTimeoutText'] as String
    ..images = json['images'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..status = json['status'] as int
    ..statusText = json['statusText'] as String
    ..resultImages = json['resultImages'] as String
    ..timeout = json['timeout'] as int
    ..timeoutText = json['timeoutText'] as String
    ..title = json['title'] as String
    ..baseUrl = json['baseUrl'] as String;
}

Map<String, dynamic> _$FeedbackVOToJson(FeedbackVO instance) =>
    <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'cleanerName': instance.cleanerName,
      'content': instance.content,
      'createTime': instance.createTime,
      'dispatchTime': instance.dispatchTime,
      'id': instance.id,
      'areaLeaderTimeout': instance.areaLeaderTimeout,
      'areaLeaderTimeoutText': instance.areaLeaderTimeoutText,
      'cleanerTimeout': instance.cleanerTimeout,
      'cleanerTimeoutText': instance.cleanerTimeoutText,
      'images': instance.images,
      'organizationBranchName': instance.organizationBranchName,
      'status': instance.status,
      'statusText': instance.statusText,
      'resultImages': instance.resultImages,
      'timeout': instance.timeout,
      'timeoutText': instance.timeoutText,
      'title': instance.title,
      'baseUrl': instance.baseUrl
    };

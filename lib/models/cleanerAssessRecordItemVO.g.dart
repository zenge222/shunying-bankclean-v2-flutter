// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleanerAssessRecordItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleanerAssessRecordItemVO _$CleanerAssessRecordItemVOFromJson(
    Map<String, dynamic> json) {
  return CleanerAssessRecordItemVO()
    ..id = json['id'] as int
    ..createId = json['createId'] as String
    ..createName = json['createName'] as String
    ..createTime = json['createTime'] as String
    ..updateId = json['updateId'] as String
    ..updateName = json['updateName'] as String
    ..updateTime = json['updateTime'] as String
    ..configId = json['configId'] as int
    ..title = json['title'] as String
    ..maxScore = (json['maxScore'] as num)?.toDouble()
    ..score = (json['score'] as num)?.toDouble();
}

Map<String, dynamic> _$CleanerAssessRecordItemVOToJson(
        CleanerAssessRecordItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createId': instance.createId,
      'createName': instance.createName,
      'createTime': instance.createTime,
      'updateId': instance.updateId,
      'updateName': instance.updateName,
      'updateTime': instance.updateTime,
      'configId': instance.configId,
      'title': instance.title,
      'maxScore': instance.maxScore,
      'score': instance.score
    };

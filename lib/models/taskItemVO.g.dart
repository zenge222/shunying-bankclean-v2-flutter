// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItemVO _$TaskItemVOFromJson(Map<String, dynamic> json) {
  return TaskItemVO()
    ..content = json['content'] as String
    ..startTime = json['startTime'] as String
    ..endTime = json['endTime'] as String
    ..cleanerName = json['cleanerName'] as String
    ..images = json['images'] as String
    ..baseUrl = json['baseUrl'] as String
    ..open = json['open'] as bool
    ..status = json['status'] as int
    ..id = json['id'] as int
    ..statusText = json['statusText'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$TaskItemVOToJson(TaskItemVO instance) =>
    <String, dynamic>{
      'content': instance.content,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'cleanerName': instance.cleanerName,
      'images': instance.images,
      'baseUrl': instance.baseUrl,
      'open': instance.open,
      'status': instance.status,
      'id': instance.id,
      'statusText': instance.statusText,
      'title': instance.title
    };

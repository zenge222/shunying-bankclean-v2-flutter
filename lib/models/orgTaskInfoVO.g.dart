// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgTaskInfoVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgTaskInfoVO _$OrgTaskInfoVOFromJson(Map<String, dynamic> json) {
  return OrgTaskInfoVO()
    ..id = json['id'] as int
    ..date = json['date'] as String
    ..select = json['select'] as bool
    ..status = json['status'] as int
    ..taskList = (json['taskList'] as List)
        ?.map((e) =>
            e == null ? null : TaskVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrgTaskInfoVOToJson(OrgTaskInfoVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'select': instance.select,
      'status': instance.status,
      'taskList': instance.taskList
    };

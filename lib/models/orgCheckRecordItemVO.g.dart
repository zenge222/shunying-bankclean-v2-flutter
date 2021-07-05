// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgCheckRecordItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCheckRecordItemVO _$OrgCheckRecordItemVOFromJson(Map<String, dynamic> json) {
  return OrgCheckRecordItemVO()
    ..id = json['id'] as int
    ..checkScore = json['checkScore'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$OrgCheckRecordItemVOToJson(
        OrgCheckRecordItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkScore': instance.checkScore,
      'title': instance.title
    };

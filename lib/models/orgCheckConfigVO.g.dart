// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgCheckConfigVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCheckConfigVO _$OrgCheckConfigVOFromJson(Map<String, dynamic> json) {
  return OrgCheckConfigVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..maxScore = json['maxScore'] as int
    ..score = json['score'] as int;
}

Map<String, dynamic> _$OrgCheckConfigVOToJson(OrgCheckConfigVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'maxScore': instance.maxScore,
      'score': instance.score
    };

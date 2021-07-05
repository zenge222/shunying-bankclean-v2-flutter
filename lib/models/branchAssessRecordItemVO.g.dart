// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchAssessRecordItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAssessRecordItemVO _$BranchAssessRecordItemVOFromJson(
    Map<String, dynamic> json) {
  return BranchAssessRecordItemVO()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..score = (json['score'] as num)?.toDouble()
    ..subTitleList = (json['subTitleList'] as List)
        ?.map((e) =>
            e == null ? null : ItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BranchAssessRecordItemVOToJson(
        BranchAssessRecordItemVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'score': instance.score,
      'subTitleList': instance.subTitleList
    };

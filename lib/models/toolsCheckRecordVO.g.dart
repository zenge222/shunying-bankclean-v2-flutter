// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolsCheckRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolsCheckRecordVO _$ToolsCheckRecordVOFromJson(Map<String, dynamic> json) {
  return ToolsCheckRecordVO()
    ..areaManagerName = json['areaManagerName'] as String
    ..createTime = json['createTime'] as String
    ..id = json['id'] as int
    ..status = json['status'] as int
    ..sumCost = (json['sumCost'] as num)?.toDouble()
    ..statusText = json['statusText'] as String
    ..title = json['title'] as String
    ..reason = json['reason'] as String
    ..itemList = (json['itemList'] as List)
        ?.map((e) => e == null
            ? null
            : ToolsApplyItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ToolsCheckRecordVOToJson(ToolsCheckRecordVO instance) =>
    <String, dynamic>{
      'areaManagerName': instance.areaManagerName,
      'createTime': instance.createTime,
      'id': instance.id,
      'status': instance.status,
      'sumCost': instance.sumCost,
      'statusText': instance.statusText,
      'title': instance.title,
      'reason': instance.reason,
      'itemList': instance.itemList
    };

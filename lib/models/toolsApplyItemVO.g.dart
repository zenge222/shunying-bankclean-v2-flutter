// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolsApplyItemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolsApplyItemVO _$ToolsApplyItemVOFromJson(Map<String, dynamic> json) {
  return ToolsApplyItemVO()
    ..checked = json['checked'] as int
    ..id = json['id'] as int
    ..passQuantity = json['passQuantity'] as int
    ..quantity = json['quantity'] as int
    ..remaining = json['remaining'] as int
    ..sumCost = (json['sumCost'] as num)?.toDouble()
    ..sumLimitQuantity = json['sumLimitQuantity'] as int
    ..sumPassQuantity = json['sumPassQuantity'] as int
    ..toolsId = json['toolsId'] as int
    ..toolsImage = json['toolsImage'] as String
    ..baseUrl = json['baseUrl'] as String
    ..toolsLimitQuantity = json['toolsLimitQuantity'] as int
    ..toolsName = json['toolsName'] as String;
}

Map<String, dynamic> _$ToolsApplyItemVOToJson(ToolsApplyItemVO instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'id': instance.id,
      'passQuantity': instance.passQuantity,
      'quantity': instance.quantity,
      'remaining': instance.remaining,
      'sumCost': instance.sumCost,
      'sumLimitQuantity': instance.sumLimitQuantity,
      'sumPassQuantity': instance.sumPassQuantity,
      'toolsId': instance.toolsId,
      'toolsImage': instance.toolsImage,
      'baseUrl': instance.baseUrl,
      'toolsLimitQuantity': instance.toolsLimitQuantity,
      'toolsName': instance.toolsName
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToolsVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolsVO _$ToolsVOFromJson(Map<String, dynamic> json) {
  return ToolsVO()
    ..id = json['id'] as int
    ..cost = (json['cost'] as num)?.toDouble()
    ..limitQuantity = json['limitQuantity'] as int
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..baseUrl = json['baseUrl'] as String
    ..quantity = json['quantity'] as int;
}

Map<String, dynamic> _$ToolsVOToJson(ToolsVO instance) => <String, dynamic>{
      'id': instance.id,
      'cost': instance.cost,
      'limitQuantity': instance.limitQuantity,
      'name': instance.name,
      'image': instance.image,
      'baseUrl': instance.baseUrl,
      'quantity': instance.quantity
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materialApplyItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialApplyItem _$MaterialApplyItemFromJson(Map<String, dynamic> json) {
  return MaterialApplyItem()
    ..quantity = json['quantity'] as int
    ..toolsName = json['toolsName'] as String
    ..toolsId = json['toolsId'] as int
    ..toolsImage = json['toolsImage'] as String
    ..checked = json['checked'] as int
    ..passQuantity = json['passQuantity'] as int
    ..toolsLimitQuantity = json['toolsLimitQuantity'] as int;
}

Map<String, dynamic> _$MaterialApplyItemToJson(MaterialApplyItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'toolsName': instance.toolsName,
      'toolsId': instance.toolsId,
      'toolsImage': instance.toolsImage,
      'checked': instance.checked,
      'passQuantity': instance.passQuantity,
      'toolsLimitQuantity': instance.toolsLimitQuantity
    };

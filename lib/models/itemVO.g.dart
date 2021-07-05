// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemVO _$ItemVOFromJson(Map<String, dynamic> json) {
  return ItemVO()
    ..key = json['key'] as int
    ..value = json['value'] as String
    ..select = json['select'] as bool;
}

Map<String, dynamic> _$ItemVOToJson(ItemVO instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'select': instance.select
    };

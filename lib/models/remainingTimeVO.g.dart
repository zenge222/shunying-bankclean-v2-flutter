// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remainingTimeVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemainingTimeVO _$RemainingTimeVOFromJson(Map<String, dynamic> json) {
  return RemainingTimeVO()
    ..route = json['route'] as bool
    ..timeFormat = json['timeFormat'] as String;
}

Map<String, dynamic> _$RemainingTimeVOToJson(RemainingTimeVO instance) =>
    <String, dynamic>{
      'route': instance.route,
      'timeFormat': instance.timeFormat
    };

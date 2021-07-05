import 'package:json_annotation/json_annotation.dart';

part 'remainingTimeVO.g.dart';

@JsonSerializable()
class RemainingTimeVO {
    RemainingTimeVO();

    bool route;
    String timeFormat;
    
    factory RemainingTimeVO.fromJson(Map<String,dynamic> json) => _$RemainingTimeVOFromJson(json);
    Map<String, dynamic> toJson() => _$RemainingTimeVOToJson(this);
}

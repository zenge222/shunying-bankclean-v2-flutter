import 'package:json_annotation/json_annotation.dart';

part 'repairHomeVO.g.dart';

@JsonSerializable()
class RepairHomeVO {
    RepairHomeVO();

    @JsonKey(name:'needCount') int needCount;
    @JsonKey(name:'repairedCount') int repairedCount;
    @JsonKey(name:'todayCount') int todayCount;
    
    factory RepairHomeVO.fromJson(Map<String,dynamic> json) => _$RepairHomeVOFromJson(json);
    Map<String, dynamic> toJson() => _$RepairHomeVOToJson(this);
}

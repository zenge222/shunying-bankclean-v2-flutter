import 'package:json_annotation/json_annotation.dart';

part 'equipmentRepairRecordVO.g.dart';

@JsonSerializable()
class EquipmentRepairRecordVO {
    EquipmentRepairRecordVO();

    @JsonKey(name:'equipmentId') int equipmentId;
    String repairEmployeeName;
    String content;
    String img;
    String createTime;
    bool open;
    
    factory EquipmentRepairRecordVO.fromJson(Map<String,dynamic> json) => _$EquipmentRepairRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$EquipmentRepairRecordVOToJson(this);
}

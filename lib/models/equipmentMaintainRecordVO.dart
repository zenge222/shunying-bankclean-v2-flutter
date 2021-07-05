import 'package:json_annotation/json_annotation.dart';

part 'equipmentMaintainRecordVO.g.dart';

@JsonSerializable()
class EquipmentMaintainRecordVO {
    EquipmentMaintainRecordVO();

    @JsonKey(name:'id') int id;
    String checkEmployeeName;
    String content;
    String createTime;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    String organizationBranchName;
    @JsonKey(name:'projectId') int projectId;
    String projectName;
    String title;
    
    factory EquipmentMaintainRecordVO.fromJson(Map<String,dynamic> json) => _$EquipmentMaintainRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$EquipmentMaintainRecordVOToJson(this);
}

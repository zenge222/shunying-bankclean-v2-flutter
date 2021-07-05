import 'package:json_annotation/json_annotation.dart';

part 'equipmentScrapRecordVO.g.dart';

@JsonSerializable()
class EquipmentScrapRecordVO {
    EquipmentScrapRecordVO();

    @JsonKey(name:'id') int id;
    String baseUrl;
    String checkName;
    String content;
    String createTime;
    @JsonKey(name:'equipmentId') int equipmentId;
    String equipmentImg;
    String equipmentName;
    String equipmentNo;
    @JsonKey(name:'equipmentType') int equipmentType;
    String img;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    String organizationBranchName;
    @JsonKey(name:'projectId') int projectId;
    String projectName;
    @JsonKey(name:'repairEmployeeId') int repairEmployeeId;
    String repairEmployeeName;
    @JsonKey(name:'status') int status;
    String title;
    
    factory EquipmentScrapRecordVO.fromJson(Map<String,dynamic> json) => _$EquipmentScrapRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$EquipmentScrapRecordVOToJson(this);
}

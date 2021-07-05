import 'package:json_annotation/json_annotation.dart';
import "equipmentRepairRecordVO.dart";
part 'equipmentVO.g.dart';

@JsonSerializable()
class EquipmentVO {
    EquipmentVO();

    @JsonKey(name:'id') int id;
    String name;
    String img;
    String baseUrl;
    String no;
    String sku;
    String address;
    @JsonKey(name:'type') int type;
    String typeText;
    @JsonKey(name:'status') int status;
    String statusText;
    String buyDate;
    String qualityDate;
    String checkCycle;
    String dutyPerson;
    @JsonKey(name:'dutyPersonId') int dutyPersonId;
    String businessName;
    String businessContactPhone;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    String organizationBranchName;
    String projectName;
    @JsonKey(name:'projectId') int projectId;
    @JsonKey(name:'deleteFlag') int deleteFlag;
    String createTime;
    List<EquipmentRepairRecordVO> recordVOList;
    
    factory EquipmentVO.fromJson(Map<String,dynamic> json) => _$EquipmentVOFromJson(json);
    Map<String, dynamic> toJson() => _$EquipmentVOToJson(this);
}

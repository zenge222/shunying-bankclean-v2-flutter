import 'package:json_annotation/json_annotation.dart';

part 'equipmentReportVO.g.dart';

@JsonSerializable()
class EquipmentReportVO {
    EquipmentReportVO();

    @JsonKey(name:'id') int id;
    String title;
    String address;
    @JsonKey(name:'status') int status;
    String statusText;
    String equipmentImg;
    String baseUrl;
    String equipmentName;
    String equipmentNo;
    @JsonKey(name:'equipmentType') int equipmentType;
    @JsonKey(name:'equipmentId') int equipmentId;
    String equipmentTypeText;
    String reportImg;
    String reportContent;
    String repairEmployeeName;
    String repairDate;
    String managerResultImg;
    String managerResultContent;
    String repairResultImg;
    String repairResultContent;
    String cleanerName;
    String organizationBranchName;
    String projectName;
    String createTime;
    
    factory EquipmentReportVO.fromJson(Map<String,dynamic> json) => _$EquipmentReportVOFromJson(json);
    Map<String, dynamic> toJson() => _$EquipmentReportVOToJson(this);
}

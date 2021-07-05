import 'package:json_annotation/json_annotation.dart';
import "propertyCheckRecordItemVO.dart";
part 'propertyCheckRecordVO.g.dart';

@JsonSerializable()
class PropertyCheckRecordVO {
    PropertyCheckRecordVO();

    @JsonKey(name:'id') int id;
    String createTime;
    List<PropertyCheckRecordItemVO> itemVOList;
    @JsonKey(name:'managerId') int managerId;
    String managerName;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    String organizationBranchName;
    @JsonKey(name:'projectId') int projectId;
    String projectName;
    @JsonKey(name:'status') int status;
    String statusText;
    
    factory PropertyCheckRecordVO.fromJson(Map<String,dynamic> json) => _$PropertyCheckRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$PropertyCheckRecordVOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'resDeviceItemVO.g.dart';

@JsonSerializable()
class ResDeviceItemVO {
    ResDeviceItemVO();

    String baseUrl;
    String businessContactPhone;
    String businessName;
    String buyDate;
    String checkCycle;
    String createTime;
    @JsonKey(name:'deleteFlag') int deleteFlag;
    String dutyPerson;
    String dutyPersonId;
    String id;
    String img;
    String name;
    String no;
    String organizationBranchId;
    String organizationBranchName;
    String projectId;
    String projectName;
    String qualityDate;
    String sku;
    @JsonKey(name:'status') int status;
    @JsonKey(name:'type') int type;
    
    factory ResDeviceItemVO.fromJson(Map<String,dynamic> json) => _$ResDeviceItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$ResDeviceItemVOToJson(this);
}

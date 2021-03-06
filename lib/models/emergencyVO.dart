import 'package:json_annotation/json_annotation.dart';

part 'emergencyVO.g.dart';

@JsonSerializable()
class EmergencyVO {
    EmergencyVO();

    String cleanerName;
    String content;
    String createTime;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'status') int status;
    String images;
    String statusText;
    String baseUrl;
    String organizationBranchName;
    String resultContent;
    String resultImages;
    String title;
    
    factory EmergencyVO.fromJson(Map<String,dynamic> json) => _$EmergencyVOFromJson(json);
    Map<String, dynamic> toJson() => _$EmergencyVOToJson(this);
}

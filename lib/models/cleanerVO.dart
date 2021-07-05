import 'package:json_annotation/json_annotation.dart';

part 'cleanerVO.g.dart';

@JsonSerializable()
class CleanerVO {
    CleanerVO();

    @JsonKey(name:'id') int id;
    String name;
    String organizationBranchName;
    String phone;
    String profile;
    bool select;
    String token;
    @JsonKey(name:'type') int type;
    String aveScore;
    String workEndTime;
    String workStartTime;
    String idCardNo;
    String taskName;
    @JsonKey(name:'taskId') int taskId;
    
    factory CleanerVO.fromJson(Map<String,dynamic> json) => _$CleanerVOFromJson(json);
    Map<String, dynamic> toJson() => _$CleanerVOToJson(this);
}

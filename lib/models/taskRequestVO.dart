import 'package:json_annotation/json_annotation.dart';

part 'taskRequestVO.g.dart';

@JsonSerializable()
class TaskRequestVO {
    TaskRequestVO();

    @JsonKey(name:'id') int id;
    String title;
    String organizationBranchName;
    @JsonKey(name:'organizationBranId') int organizationBranId;
    String startTime;
    String endTime;
    @JsonKey(name:'duration') double duration;
    String workDate;
    String createTime;
    @JsonKey(name:'status') int status;
    String statusText;
    
    factory TaskRequestVO.fromJson(Map<String,dynamic> json) => _$TaskRequestVOFromJson(json);
    Map<String, dynamic> toJson() => _$TaskRequestVOToJson(this);
}

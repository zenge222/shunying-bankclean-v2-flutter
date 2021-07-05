import 'package:json_annotation/json_annotation.dart';
import "userVO.dart";
import "taskItemVO.dart";
part 'orgCheckInfoVO.g.dart';

@JsonSerializable()
class OrgCheckInfoVO {
    OrgCheckInfoVO();

    String orgBranchName;
    String address;
    @JsonKey(name:'aveScore') double aveScore;
    String subTitle;
    @JsonKey(name:'orgCheckRecordCount') int orgCheckRecordCount;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'finishTaskCount') int finishTaskCount;
    @JsonKey(name:'unFinishTaskCount') int unFinishTaskCount;
    @JsonKey(name:'onTime') int onTime;
    @JsonKey(name:'outTime') int outTime;
    List<UserVO> userList;
    List<TaskItemVO> taskItemVOList;
    
    factory OrgCheckInfoVO.fromJson(Map<String,dynamic> json) => _$OrgCheckInfoVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgCheckInfoVOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import "branchAssessRecordVO.dart";
part 'areaLeaderAssessVO.g.dart';

@JsonSerializable()
class AreaLeaderAssessVO {
    AreaLeaderAssessVO();

    String profile;
    String baseUrl;
    String name;
    String phone;
    @JsonKey(name:'orgBranchCount') int orgBranchCount;
    @JsonKey(name:'orgCheckCount') int orgCheckCount;
    @JsonKey(name:'aveScore') double aveScore;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'satisfyingCount') int satisfyingCount;
    @JsonKey(name:'general') int general;
    @JsonKey(name:'unSatisfying') int unSatisfying;
    @JsonKey(name:'onTime') int onTime;
    @JsonKey(name:'outTime') int outTime;
    List<BranchAssessRecordVO> branchAssessRecordVOList;
    
    factory AreaLeaderAssessVO.fromJson(Map<String,dynamic> json) => _$AreaLeaderAssessVOFromJson(json);
    Map<String, dynamic> toJson() => _$AreaLeaderAssessVOToJson(this);
}

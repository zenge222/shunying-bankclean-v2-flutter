import 'package:json_annotation/json_annotation.dart';
import "branchAssessRecordItemVO.dart";
part 'branchAssessRecordVO.g.dart';

@JsonSerializable()
class BranchAssessRecordVO {
    BranchAssessRecordVO();

    @JsonKey(name:'id') int id;
    String title;
    @JsonKey(name:'month') int month;
    @JsonKey(name:'year') int year;
    String organizationBranchName;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    @JsonKey(name:'bankUserId') int bankUserId;
    String subTitle;
    @JsonKey(name:'aveScore') double aveScore;
    String createTime;
    List<BranchAssessRecordItemVO> itemVOList;
    
    factory BranchAssessRecordVO.fromJson(Map<String,dynamic> json) => _$BranchAssessRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$BranchAssessRecordVOToJson(this);
}

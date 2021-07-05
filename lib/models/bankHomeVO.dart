import 'package:json_annotation/json_annotation.dart';
import "taskItemVO.dart";
part 'bankHomeVO.g.dart';

@JsonSerializable()
class BankHomeVO {
    BankHomeVO();

    String image;
    String orgBranchName;
    String baseUrl;
    @JsonKey(name:'taskItemRecordCount') int taskItemRecordCount;
    @JsonKey(name:'orgBranchId') int orgBranchId;
    @JsonKey(name:'allTaskItemRecordCount') int allTaskItemRecordCount;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'allFeedbackCount') int allFeedbackCount;
    List<TaskItemVO> taskItemVOList;
    
    factory BankHomeVO.fromJson(Map<String,dynamic> json) => _$BankHomeVOFromJson(json);
    Map<String, dynamic> toJson() => _$BankHomeVOToJson(this);
}

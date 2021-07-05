import 'package:json_annotation/json_annotation.dart';
import "toolsApplyVO.dart";
import "toolsApplyItemVO.dart";
part 'orgToolsApplyInfoVO.g.dart';

@JsonSerializable()
class OrgToolsApplyInfoVO {
    OrgToolsApplyInfoVO();

    String orgBranchName;
    String orgBranchImage;
    @JsonKey(name:'overBudget') int overBudget;
    String overBudgetText;
    @JsonKey(name:'status') int status;
    String statusText;
    String applyCleanerNames;
    @JsonKey(name:'sumQuantity') int sumQuantity;
    @JsonKey(name:'orgBranchId') int orgBranchId;
    List<ToolsApplyVO> applyVOList;
    List<ToolsApplyItemVO> itemVOList;
    
    factory OrgToolsApplyInfoVO.fromJson(Map<String,dynamic> json) => _$OrgToolsApplyInfoVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgToolsApplyInfoVOToJson(this);
}

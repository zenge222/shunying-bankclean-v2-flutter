import 'package:json_annotation/json_annotation.dart';
import "toolsApplyItemVO.dart";
part 'toolsApplyVO.g.dart';

@JsonSerializable()
class ToolsApplyVO {
    ToolsApplyVO();

    String cleanerName;
    String createTime;
    @JsonKey(name:'id') int id;
    String mark;
    List<ToolsApplyItemVO> materialApplyItemVOList;
    String organizationBranchName;
    String reason;
    @JsonKey(name:'status') int status;
    String statusText;
    String title;
    
    factory ToolsApplyVO.fromJson(Map<String,dynamic> json) => _$ToolsApplyVOFromJson(json);
    Map<String, dynamic> toJson() => _$ToolsApplyVOToJson(this);
}

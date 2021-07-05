import 'package:json_annotation/json_annotation.dart';
import "toolsApplyItemVO.dart";
part 'toolsCheckRecordVO.g.dart';

@JsonSerializable()
class ToolsCheckRecordVO {
    ToolsCheckRecordVO();

    String areaManagerName;
    String createTime;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'status') int status;
    @JsonKey(name:'sumCost') double sumCost;
    String statusText;
    String title;
    String reason;
    List<ToolsApplyItemVO> itemList;
    
    factory ToolsCheckRecordVO.fromJson(Map<String,dynamic> json) => _$ToolsCheckRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$ToolsCheckRecordVOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import "orgBranchVO.dart";
import "taskVO.dart";
part 'indexTaskInfo.g.dart';

@JsonSerializable()
class IndexTaskInfo {
    IndexTaskInfo();

    List<OrgBranchVO> orgBranchVOList;
    List<TaskVO> taskVOList;
    
    factory IndexTaskInfo.fromJson(Map<String,dynamic> json) => _$IndexTaskInfoFromJson(json);
    Map<String, dynamic> toJson() => _$IndexTaskInfoToJson(this);
}

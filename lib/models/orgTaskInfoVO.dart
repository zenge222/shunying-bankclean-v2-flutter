import 'package:json_annotation/json_annotation.dart';
import "taskVO.dart";
part 'orgTaskInfoVO.g.dart';

@JsonSerializable()
class OrgTaskInfoVO {
    OrgTaskInfoVO();

    @JsonKey(name:'id') int id;
    String date;
    bool select;
    @JsonKey(name:'status') int status;
    List<TaskVO> taskList;
    
    factory OrgTaskInfoVO.fromJson(Map<String,dynamic> json) => _$OrgTaskInfoVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgTaskInfoVOToJson(this);
}

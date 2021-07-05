import 'package:json_annotation/json_annotation.dart';

part 'taskTempVO.g.dart';

@JsonSerializable()
class TaskTempVO {
    TaskTempVO();

    String areaManagerName;
    String createTime;
    String endTime;
    @JsonKey(name:'id') int id;
    String organizationBranchName;
    String startTime;
    String title;
    
    factory TaskTempVO.fromJson(Map<String,dynamic> json) => _$TaskTempVOFromJson(json);
    Map<String, dynamic> toJson() => _$TaskTempVOToJson(this);
}

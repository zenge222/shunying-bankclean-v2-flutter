import 'package:json_annotation/json_annotation.dart';
import "taskItemVO.dart";
part 'taskVO.g.dart';

@JsonSerializable()
class TaskVO {
    TaskVO();

    @JsonKey(name:'id') int id;
    @JsonKey(name:'cleanerId') int cleanerId;
    @JsonKey(name:'organizationBranchId') int organizationBranchId;
    String title;
    String cleanerName;
    String cleanerPhone;
    String baseUrl;
    String organizationBranchName;
    bool select;
    String startTime;
    String createTime;
    String areaManagerName;
    String workDate;
    String endTime;
    String cleanerProfile;
    List<TaskItemVO> taskItemVOList;
    
    factory TaskVO.fromJson(Map<String,dynamic> json) => _$TaskVOFromJson(json);
    Map<String, dynamic> toJson() => _$TaskVOToJson(this);
}

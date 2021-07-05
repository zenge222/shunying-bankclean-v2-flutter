import 'package:json_annotation/json_annotation.dart';

part 'workOffApplyVO.g.dart';

@JsonSerializable()
class WorkOffApplyVO {
    WorkOffApplyVO();

    String areaManagerName;
    String cleanerName;
    String createTime;
    String endDate;
    @JsonKey(name:'endTime') int endTime;
    String endTimeText;
    @JsonKey(name:'id') int id;
    String insteadCleanerName;
    String organizationBranchName;
    String reason;
    String startDate;
    @JsonKey(name:'startTime') int startTime;
    String startTimeText;
    @JsonKey(name:'status') int status;
    String statusText;
    String title;
    @JsonKey(name:'type') int type;
    String typeText;
    
    factory WorkOffApplyVO.fromJson(Map<String,dynamic> json) => _$WorkOffApplyVOFromJson(json);
    Map<String, dynamic> toJson() => _$WorkOffApplyVOToJson(this);
}

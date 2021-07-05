import 'package:json_annotation/json_annotation.dart';

part 'cleanerAttendanceVO.g.dart';

@JsonSerializable()
class CleanerAttendanceVO {
    CleanerAttendanceVO();

    String cleanerName;
    String organizationBranchName;
    String createTime;
    String firstTime;
    String secondTime;
    @JsonKey(name:'firstStatus') int firstStatus;
    String firstStatusText;
    @JsonKey(name:'secondStatus') int secondStatus;
    String secondStatusText;
    
    factory CleanerAttendanceVO.fromJson(Map<String,dynamic> json) => _$CleanerAttendanceVOFromJson(json);
    Map<String, dynamic> toJson() => _$CleanerAttendanceVOToJson(this);
}

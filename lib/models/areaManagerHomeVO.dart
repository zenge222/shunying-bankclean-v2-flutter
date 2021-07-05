import 'package:json_annotation/json_annotation.dart';
import "cleanerAttendanceVO.dart";
part 'areaManagerHomeVO.g.dart';

@JsonSerializable()
class AreaManagerHomeVO {
    AreaManagerHomeVO();

    @JsonKey(name:'taskRequestCount') int taskRequestCount;
    @JsonKey(name:'workOffApplyCount') int workOffApplyCount;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'messageCount') int messageCount;
    @JsonKey(name:'later') int later;
    @JsonKey(name:'early') int early;
    @JsonKey(name:'lack') int lack;
    @JsonKey(name:'workOffCount') int workOffCount;
    @JsonKey(name:'absenteeism') int absenteeism;
    @JsonKey(name:'finishTaskCount') int finishTaskCount;
    @JsonKey(name:'allTaskCount') int allTaskCount;
    @JsonKey(name:'finishFeedbackCount') int finishFeedbackCount;
    @JsonKey(name:'allFeedbackCount') int allFeedbackCount;
    @JsonKey(name:'attendanceCount') int attendanceCount;
    @JsonKey(name:'allAttendanceCount') int allAttendanceCount;
    bool toolsCheck;
    List<CleanerAttendanceVO> attendanceVOList;
    
    factory AreaManagerHomeVO.fromJson(Map<String,dynamic> json) => _$AreaManagerHomeVOFromJson(json);
    Map<String, dynamic> toJson() => _$AreaManagerHomeVOToJson(this);
}

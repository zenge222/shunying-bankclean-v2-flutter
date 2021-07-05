import 'package:json_annotation/json_annotation.dart';
import "cleanerAttendanceVO.dart";
import "cleanerAssessRecordItemVO.dart";
part 'cleanerAttendanceInfoVO.g.dart';

@JsonSerializable()
class CleanerAttendanceInfoVO {
    CleanerAttendanceInfoVO();

    String profile;
    String cleanerName;
    String orgBranchName;
    String phone;
    String startWorkTime;
    String endWorkTime;
    String baseUrl;
    @JsonKey(name:'accessScore') double accessScore;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'taskFinish') int taskFinish;
    @JsonKey(name:'taskUnFinish') int taskUnFinish;
    @JsonKey(name:'onTime') int onTime;
    @JsonKey(name:'outTime') int outTime;
    @JsonKey(name:'workDayCount') int workDayCount;
    @JsonKey(name:'workTimeCount') double workTimeCount;
    @JsonKey(name:'workOffCount') int workOffCount;
    @JsonKey(name:'later') int later;
    @JsonKey(name:'early') int early;
    @JsonKey(name:'lack') int lack;
    @JsonKey(name:'absenteeism') int absenteeism;
    List<CleanerAttendanceVO> attendanceVOList;
    List<CleanerAssessRecordItemVO> cleanerAssessRecordItemVOList;
    
    factory CleanerAttendanceInfoVO.fromJson(Map<String,dynamic> json) => _$CleanerAttendanceInfoVOFromJson(json);
    Map<String, dynamic> toJson() => _$CleanerAttendanceInfoVOToJson(this);
}

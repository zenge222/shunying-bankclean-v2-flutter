import 'package:json_annotation/json_annotation.dart';
import "taskItemVO.dart";
part 'cleanerHomeVO.g.dart';

@JsonSerializable()
class CleanerHomeVO {
    CleanerHomeVO();

    String orgBranchName;
    String orgImage;
    String baseUrl;
    @JsonKey(name:'feedbackCount') int feedbackCount;
    @JsonKey(name:'todayHaveWork') int todayHaveWork;
    @JsonKey(name:'tomorrowWork') int tomorrowWork;
    @JsonKey(name:'longitude') double longitude;
    @JsonKey(name:'latitude') double latitude;
    String todayTitle;
    String todayAddress;
    String todayStartWorkTime;
    String todayEndWorkTime;
    String tomorrowTitle;
    String tomorrowAddress;
    String tomorrowStartWorkTime;
    String tomorrowEndWorkTime;
    List<TaskItemVO> taskItemVOList;
    
    factory CleanerHomeVO.fromJson(Map<String,dynamic> json) => _$CleanerHomeVOFromJson(json);
    Map<String, dynamic> toJson() => _$CleanerHomeVOToJson(this);
}

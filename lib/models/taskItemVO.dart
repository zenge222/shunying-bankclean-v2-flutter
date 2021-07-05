import 'package:json_annotation/json_annotation.dart';

part 'taskItemVO.g.dart';

@JsonSerializable()
class TaskItemVO {
    TaskItemVO();

    String content;
    String startTime;
    String endTime;
    String cleanerName;
    String images;
    String baseUrl;
    bool open;
    @JsonKey(name:'status') int status;
    @JsonKey(name:'id') int id;
    String statusText;
    String title;
    
    factory TaskItemVO.fromJson(Map<String,dynamic> json) => _$TaskItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$TaskItemVOToJson(this);
}

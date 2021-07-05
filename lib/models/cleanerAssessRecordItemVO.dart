import 'package:json_annotation/json_annotation.dart';

part 'cleanerAssessRecordItemVO.g.dart';

@JsonSerializable()
class CleanerAssessRecordItemVO {
    CleanerAssessRecordItemVO();

    @JsonKey(name:'id') int id;
    String createId;
    String createName;
    String createTime;
    String updateId;
    String updateName;
    String updateTime;
    @JsonKey(name:'configId') int configId;
    String title;
    @JsonKey(name:'maxScore') double maxScore;
    @JsonKey(name:'score') double score;
    
    factory CleanerAssessRecordItemVO.fromJson(Map<String,dynamic> json) => _$CleanerAssessRecordItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$CleanerAssessRecordItemVOToJson(this);
}

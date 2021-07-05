import 'package:json_annotation/json_annotation.dart';

part 'messageVO.g.dart';

@JsonSerializable()
class MessageVO {
    MessageVO();

    String areaManagerName;
    String cleanerName;
    String content;
    String createTime;
    String images;
    String organizationBranchName;
    @JsonKey(name:'readStatus') int readStatus;
    @JsonKey(name:'auditStatus') int auditStatus;
    @JsonKey(name:'id') int id;
    String readStatusText;
    String subTitle;
    String baseUrl;
    String title;
    @JsonKey(name:'type') int type;
    @JsonKey(name:'days') int days;
    String typeText;
    
    factory MessageVO.fromJson(Map<String,dynamic> json) => _$MessageVOFromJson(json);
    Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}

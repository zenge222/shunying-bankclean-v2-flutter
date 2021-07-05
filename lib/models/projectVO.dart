import 'package:json_annotation/json_annotation.dart';

part 'projectVO.g.dart';

@JsonSerializable()
class ProjectVO {
    ProjectVO();

    @JsonKey(name:'id') int id;
    @JsonKey(name:'createId') int createId;
    String createName;
    String createTime;
    String updateId;
    String updateName;
    String updateTime;
    String name;
    String image;
    @JsonKey(name:'status') int status;
    @JsonKey(name:'type') int type;
    @JsonKey(name:'projectUserId') int projectUserId;
    String projectUserName;
    String bankUserName;
    @JsonKey(name:'bankUserId') int bankUserId;
    String startDate;
    String endDate;
    String orgName;
    @JsonKey(name:'deleteFlag') int deleteFlag;
    bool select;
    
    factory ProjectVO.fromJson(Map<String,dynamic> json) => _$ProjectVOFromJson(json);
    Map<String, dynamic> toJson() => _$ProjectVOToJson(this);
}

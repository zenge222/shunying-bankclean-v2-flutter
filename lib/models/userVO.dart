import 'package:json_annotation/json_annotation.dart';

part 'userVO.g.dart';

@JsonSerializable()
class UserVO {
    UserVO();

    @JsonKey(name:'id') int id;
    String token;
    String name;
    String phone;
    String organizationBranchName;
    @JsonKey(name:'type') int type;
    String typeName;
    String idCardNo;
    bool select;
    @JsonKey(name:'aveScore') double aveScore;
    String profile;
    String taskName;
    String baseUrl;
    @JsonKey(name:'taskId') int taskId;
    String workStartTime;
    String workEndTime;
    
    factory UserVO.fromJson(Map<String,dynamic> json) => _$UserVOFromJson(json);
    Map<String, dynamic> toJson() => _$UserVOToJson(this);
}

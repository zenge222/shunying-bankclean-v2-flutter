import 'package:json_annotation/json_annotation.dart';

part 'orgBranchVO.g.dart';

@JsonSerializable()
class OrgBranchVO {
    OrgBranchVO();

    String address;
    String areaManagerName;
    String areaManagerPhone;
    @JsonKey(name:'checkCount') int checkCount;
    @JsonKey(name:'during') int during;
    @JsonKey(name:'allocation') int allocation;
    @JsonKey(name:'areaManagerId') int areaManagerId;
    @JsonKey(name:'id') int id;
    String latestCheckTime;
    String name;
    String baseUrl;
    String image;
    String organizationName;
    String projectName;
    bool select;
    
    factory OrgBranchVO.fromJson(Map<String,dynamic> json) => _$OrgBranchVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgBranchVOToJson(this);
}

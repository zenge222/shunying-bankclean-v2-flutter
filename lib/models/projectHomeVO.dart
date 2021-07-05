import 'package:json_annotation/json_annotation.dart';

part 'projectHomeVO.g.dart';

@JsonSerializable()
class ProjectHomeVO {
    ProjectHomeVO();

    @JsonKey(name:'orgBranchUnAllocationCount') int orgBranchUnAllocationCount;
    @JsonKey(name:'toolsUnCheckCount') int toolsUnCheckCount;
    
    factory ProjectHomeVO.fromJson(Map<String,dynamic> json) => _$ProjectHomeVOFromJson(json);
    Map<String, dynamic> toJson() => _$ProjectHomeVOToJson(this);
}

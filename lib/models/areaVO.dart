import 'package:json_annotation/json_annotation.dart';

part 'areaVO.g.dart';

@JsonSerializable()
class AreaVO {
    AreaVO();

    String areaManagerName;
    @JsonKey(name:'id') int id;
    String name;
    @JsonKey(name:'orgBranchCount') int orgBranchCount;
    @JsonKey(name:'status') int status;
    String statusText;
    
    factory AreaVO.fromJson(Map<String,dynamic> json) => _$AreaVOFromJson(json);
    Map<String, dynamic> toJson() => _$AreaVOToJson(this);
}

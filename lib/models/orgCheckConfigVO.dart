import 'package:json_annotation/json_annotation.dart';

part 'orgCheckConfigVO.g.dart';

@JsonSerializable()
class OrgCheckConfigVO {
    OrgCheckConfigVO();

    @JsonKey(name:'id') int id;
    String title;
    @JsonKey(name:'maxScore') int maxScore;
    @JsonKey(name:'score') int score;
    
    factory OrgCheckConfigVO.fromJson(Map<String,dynamic> json) => _$OrgCheckConfigVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgCheckConfigVOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'orgCheckRecordItemVO.g.dart';

@JsonSerializable()
class OrgCheckRecordItemVO {
    OrgCheckRecordItemVO();

    @JsonKey(name:'id') int id;
    @JsonKey(name:'checkScore') int checkScore;
    String title;
    
    factory OrgCheckRecordItemVO.fromJson(Map<String,dynamic> json) => _$OrgCheckRecordItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgCheckRecordItemVOToJson(this);
}

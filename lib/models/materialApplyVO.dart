import 'package:json_annotation/json_annotation.dart';
import "materialApplyItem.dart";
part 'materialApplyVO.g.dart';

@JsonSerializable()
class MaterialApplyVO {
    MaterialApplyVO();

    String cleanerName;
    String createTime;
    String mark;
    String organizationBranchName;
    String reason;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'status') int status;
    String statusText;
    String title;
    List<MaterialApplyItem> materialApplyItemVOList;
    
    factory MaterialApplyVO.fromJson(Map<String,dynamic> json) => _$MaterialApplyVOFromJson(json);
    Map<String, dynamic> toJson() => _$MaterialApplyVOToJson(this);
}

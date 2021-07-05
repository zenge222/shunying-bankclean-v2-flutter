import 'package:json_annotation/json_annotation.dart';
import "itemVO.dart";
part 'branchAssessRecordItemVO.g.dart';

@JsonSerializable()
class BranchAssessRecordItemVO {
    BranchAssessRecordItemVO();

    @JsonKey(name:'id') int id;
    String title;
    String subTitle;
    @JsonKey(name:'score') double score;
    List<ItemVO> subTitleList;
    
    factory BranchAssessRecordItemVO.fromJson(Map<String,dynamic> json) => _$BranchAssessRecordItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$BranchAssessRecordItemVOToJson(this);
}

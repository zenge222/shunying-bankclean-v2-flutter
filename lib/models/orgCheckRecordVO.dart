import 'package:json_annotation/json_annotation.dart';
import "orgCheckRecordItemVO.dart";
part 'orgCheckRecordVO.g.dart';

@JsonSerializable()
class OrgCheckRecordVO {
    OrgCheckRecordVO();

    @JsonKey(name:'id') int id;
    String areaManagerName;
    String organizationBranchName;
    String bankChatContent;
    String cleanerChatContent;
    @JsonKey(name:'aveScore') double  aveScore;
    String orgImage;
    @JsonKey(name:'interval') int interval;
    @JsonKey(name:'checkCount') int checkCount;
    @JsonKey(name:'timeout') int timeout;
    String nearDate;
    bool showTimeout;
    String createTime;
    String baseUrl;
    List<OrgCheckRecordVO> recordList;
    List<OrgCheckRecordItemVO> recordItemVOList;
    
    factory OrgCheckRecordVO.fromJson(Map<String,dynamic> json) => _$OrgCheckRecordVOFromJson(json);
    Map<String, dynamic> toJson() => _$OrgCheckRecordVOToJson(this);
}

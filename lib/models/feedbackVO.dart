import 'package:json_annotation/json_annotation.dart';

part 'feedbackVO.g.dart';

@JsonSerializable()
class FeedbackVO {
    FeedbackVO();

    String areaManagerName;
    String cleanerName;
    String content;
    String createTime;
    String dispatchTime;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'areaLeaderTimeout') int areaLeaderTimeout;
    String areaLeaderTimeoutText;
    @JsonKey(name:'cleanerTimeout') int cleanerTimeout;
    String cleanerTimeoutText;
    String images;
    String organizationBranchName;
    @JsonKey(name:'status') int status;
    String statusText;
    String resultImages;
    @JsonKey(name:'timeout') int timeout;
    String timeoutText;
    String title;
    String baseUrl;
    
    factory FeedbackVO.fromJson(Map<String,dynamic> json) => _$FeedbackVOFromJson(json);
    Map<String, dynamic> toJson() => _$FeedbackVOToJson(this);
}

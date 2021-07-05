import 'package:json_annotation/json_annotation.dart';

part 'adviceFeedbackVO.g.dart';

@JsonSerializable()
class AdviceFeedbackVO {
    AdviceFeedbackVO();

    @JsonKey(name:'id') int id;
    String title;
    String subTitle;
    String content;
    String images;
    String baseUrl;
    @JsonKey(name:'bankUserId') int bankUserId;
    String bankUserName;
    String bankUserPhone;
    @JsonKey(name:'readStatus') int readStatus;
    String readStatusText;
    String createTime;
    
    factory AdviceFeedbackVO.fromJson(Map<String,dynamic> json) => _$AdviceFeedbackVOFromJson(json);
    Map<String, dynamic> toJson() => _$AdviceFeedbackVOToJson(this);
}

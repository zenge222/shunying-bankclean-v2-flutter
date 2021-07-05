import 'package:json_annotation/json_annotation.dart';

part 'leaveTypeVo.g.dart';

@JsonSerializable()
class LeaveTypeVo {
    LeaveTypeVo();

    @JsonKey(name:'key') int key;
    String value;
    
    factory LeaveTypeVo.fromJson(Map<String,dynamic> json) => _$LeaveTypeVoFromJson(json);
    Map<String, dynamic> toJson() => _$LeaveTypeVoToJson(this);
}

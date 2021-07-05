import 'package:json_annotation/json_annotation.dart';

part 'selParamsVo.g.dart';

@JsonSerializable()
class SelParamsVo {
    SelParamsVo();

    @JsonKey(name:'id') int id;
    @JsonKey(name:'index') int index;
    
    factory SelParamsVo.fromJson(Map<String,dynamic> json) => _$SelParamsVoFromJson(json);
    Map<String, dynamic> toJson() => _$SelParamsVoToJson(this);
}

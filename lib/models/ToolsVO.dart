import 'package:json_annotation/json_annotation.dart';

part 'ToolsVO.g.dart';

@JsonSerializable()
class ToolsVO {
    ToolsVO();

    @JsonKey(name:'id') int id;
    @JsonKey(name:'cost') double cost;
    @JsonKey(name:'limitQuantity') int limitQuantity;
    String name;
    String image;
    String baseUrl;
    @JsonKey(name:'quantity') int quantity;
    
    factory ToolsVO.fromJson(Map<String,dynamic> json) => _$ToolsVOFromJson(json);
    Map<String, dynamic> toJson() => _$ToolsVOToJson(this);
}

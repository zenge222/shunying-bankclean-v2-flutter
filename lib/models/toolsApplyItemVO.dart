import 'package:json_annotation/json_annotation.dart';

part 'toolsApplyItemVO.g.dart';

@JsonSerializable()
class ToolsApplyItemVO {
    ToolsApplyItemVO();

    @JsonKey(name:'checked') int checked;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'passQuantity') int passQuantity;
    @JsonKey(name:'quantity') int quantity;
    @JsonKey(name:'remaining') int remaining;
    @JsonKey(name:'sumCost') double sumCost;
    @JsonKey(name:'sumLimitQuantity') int sumLimitQuantity;
    @JsonKey(name:'sumPassQuantity') int sumPassQuantity;
    @JsonKey(name:'toolsId') int toolsId;
    String toolsImage;
    String baseUrl;
    @JsonKey(name:'toolsLimitQuantity') int toolsLimitQuantity;
    String toolsName;
    
    factory ToolsApplyItemVO.fromJson(Map<String,dynamic> json) => _$ToolsApplyItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$ToolsApplyItemVOToJson(this);
}

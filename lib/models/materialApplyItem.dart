import 'package:json_annotation/json_annotation.dart';

part 'materialApplyItem.g.dart';

@JsonSerializable()
class MaterialApplyItem {
    MaterialApplyItem();

    @JsonKey(name:'quantity') int quantity;
    String toolsName;
    @JsonKey(name:'toolsId') int toolsId;
    String toolsImage;
    @JsonKey(name:'checked') int checked;
    @JsonKey(name:'passQuantity') int passQuantity;
    @JsonKey(name:'toolsLimitQuantity') int toolsLimitQuantity;
    
    factory MaterialApplyItem.fromJson(Map<String,dynamic> json) => _$MaterialApplyItemFromJson(json);
    Map<String, dynamic> toJson() => _$MaterialApplyItemToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'itemVO.g.dart';

@JsonSerializable()
class ItemVO {
    ItemVO();

    @JsonKey(name:'key') int key;
    String value;
    bool select;
    
    factory ItemVO.fromJson(Map<String,dynamic> json) => _$ItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$ItemVOToJson(this);
}

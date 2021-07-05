import 'package:json_annotation/json_annotation.dart';

part 'propertyCheckRecordItemVO.g.dart';

@JsonSerializable()
class PropertyCheckRecordItemVO {
    PropertyCheckRecordItemVO();

    @JsonKey(name:'equipmentId') int equipmentId;
    String equipmentBuyDate;
    String equipmentDutyPerson;
    String equipmentName;
    String equipmentNo;
    String equipmentSku;
    @JsonKey(name:'equipmentType') int equipmentType;
    @JsonKey(name:'id') int id;
    @JsonKey(name:'status') int status;
    
    factory PropertyCheckRecordItemVO.fromJson(Map<String,dynamic> json) => _$PropertyCheckRecordItemVOFromJson(json);
    Map<String, dynamic> toJson() => _$PropertyCheckRecordItemVOToJson(this);
}

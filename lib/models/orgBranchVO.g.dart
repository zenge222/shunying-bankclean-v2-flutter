// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgBranchVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgBranchVO _$OrgBranchVOFromJson(Map<String, dynamic> json) {
  return OrgBranchVO()
    ..address = json['address'] as String
    ..areaManagerName = json['areaManagerName'] as String
    ..areaManagerPhone = json['areaManagerPhone'] as String
    ..checkCount = json['checkCount'] as int
    ..during = json['during'] as int
    ..allocation = json['allocation'] as int
    ..areaManagerId = json['areaManagerId'] as int
    ..id = json['id'] as int
    ..latestCheckTime = json['latestCheckTime'] as String
    ..name = json['name'] as String
    ..baseUrl = json['baseUrl'] as String
    ..image = json['image'] as String
    ..organizationName = json['organizationName'] as String
    ..projectName = json['projectName'] as String
    ..select = json['select'] as bool;
}

Map<String, dynamic> _$OrgBranchVOToJson(OrgBranchVO instance) =>
    <String, dynamic>{
      'address': instance.address,
      'areaManagerName': instance.areaManagerName,
      'areaManagerPhone': instance.areaManagerPhone,
      'checkCount': instance.checkCount,
      'during': instance.during,
      'allocation': instance.allocation,
      'areaManagerId': instance.areaManagerId,
      'id': instance.id,
      'latestCheckTime': instance.latestCheckTime,
      'name': instance.name,
      'baseUrl': instance.baseUrl,
      'image': instance.image,
      'organizationName': instance.organizationName,
      'projectName': instance.projectName,
      'select': instance.select
    };

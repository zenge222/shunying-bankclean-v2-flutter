// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgCheckRecordVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCheckRecordVO _$OrgCheckRecordVOFromJson(Map<String, dynamic> json) {
  return OrgCheckRecordVO()
    ..id = json['id'] as int
    ..areaManagerName = json['areaManagerName'] as String
    ..organizationBranchName = json['organizationBranchName'] as String
    ..bankChatContent = json['bankChatContent'] as String
    ..cleanerChatContent = json['cleanerChatContent'] as String
    ..aveScore = (json['aveScore'] as num)?.toDouble()
    ..orgImage = json['orgImage'] as String
    ..interval = json['interval'] as int
    ..checkCount = json['checkCount'] as int
    ..timeout = json['timeout'] as int
    ..nearDate = json['nearDate'] as String
    ..showTimeout = json['showTimeout'] as bool
    ..createTime = json['createTime'] as String
    ..baseUrl = json['baseUrl'] as String
    ..recordList = (json['recordList'] as List)
        ?.map((e) => e == null
            ? null
            : OrgCheckRecordVO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..recordItemVOList = (json['recordItemVOList'] as List)
        ?.map((e) => e == null
            ? null
            : OrgCheckRecordItemVO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrgCheckRecordVOToJson(OrgCheckRecordVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'areaManagerName': instance.areaManagerName,
      'organizationBranchName': instance.organizationBranchName,
      'bankChatContent': instance.bankChatContent,
      'cleanerChatContent': instance.cleanerChatContent,
      'aveScore': instance.aveScore,
      'orgImage': instance.orgImage,
      'interval': instance.interval,
      'checkCount': instance.checkCount,
      'timeout': instance.timeout,
      'nearDate': instance.nearDate,
      'showTimeout': instance.showTimeout,
      'createTime': instance.createTime,
      'baseUrl': instance.baseUrl,
      'recordList': instance.recordList,
      'recordItemVOList': instance.recordItemVOList
    };

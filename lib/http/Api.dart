import 'package:bank_clean_flutter/config/service_url.dart';
import 'package:bank_clean_flutter/http/HttpResponse.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/adviceFeedbackVO.dart';
import 'package:bank_clean_flutter/models/areaLeaderAssessVO.dart';
import 'package:bank_clean_flutter/models/areaManagerHomeVO.dart';
import 'package:bank_clean_flutter/models/areaVO.dart';
import 'package:bank_clean_flutter/models/bankHomeVO.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/models/cleanerAssessRecordItemVO.dart';
import 'package:bank_clean_flutter/models/cleanerAttendanceInfoVO.dart';
import 'package:bank_clean_flutter/models/cleanerHomeVO.dart';
import 'package:bank_clean_flutter/models/cleanerVO.dart';
import 'package:bank_clean_flutter/models/emergencyVO.dart';
import 'package:bank_clean_flutter/models/feedbackVO.dart';
import 'package:bank_clean_flutter/models/index.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/models/leaveTypeVo.dart';
import 'package:bank_clean_flutter/models/materialApplyVO.dart';
import 'package:bank_clean_flutter/models/messageVO.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/models/orgCheckConfigVO.dart';
import 'package:bank_clean_flutter/models/orgCheckInfoVO.dart';
import 'package:bank_clean_flutter/models/orgCheckRecordItemVO.dart';
import 'package:bank_clean_flutter/models/orgCheckRecordVO.dart';
import 'package:bank_clean_flutter/models/orgTaskInfoVO.dart';
import 'package:bank_clean_flutter/models/orgToolsApplyInfoVO.dart';
import 'package:bank_clean_flutter/models/projectHomeVO.dart';
import 'package:bank_clean_flutter/models/remainingTimeVO.dart';
import 'package:bank_clean_flutter/models/repairHomeVO.dart';
import 'package:bank_clean_flutter/models/taskRequestVO.dart';
import 'package:bank_clean_flutter/models/taskTempVO.dart';
import 'package:bank_clean_flutter/models/taskVO.dart';
import 'package:bank_clean_flutter/models/toolsCheckRecordVO.dart';
import 'package:bank_clean_flutter/models/user.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/models/workOffApplyVO.dart';
import 'dart:convert';
import 'HttpServe.dart';

///???????????????
class Api {
  ///demo1
  static Future<HttpResponse<User>> getUserInfo({Map map}) async {
    String content = await HttpServe.get("equipment/test", map: map);
    HttpResponse<User> response = HttpResponse.fromJson(json.decode(content));
    response.data = User.fromJson(response.dataMap);
    return response;
  }

  ///demo2
  static Future<HttpResponse<User>> getUserInfo2(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post("equipment/test2", formData: formData, map: map);
    HttpResponse<User> response = HttpResponse.fromJson(json.decode(content));
    response.data = User.fromJson(response.dataMap);
    return response;
  }

  /// ???????????????
  static Future<HttpResponse<void>> getPhoneCode(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('login/send/captcha',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ???????????????
  static Future<HttpResponse<UserVO>> sendCodeLogin(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('login/captcha', formData: formData, map: map);
    HttpResponse<UserVO> response = HttpResponse.fromJson(json.decode(content));
//    response.data = UserVO.fromJson(response.dataMap);
//    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> uploadImage(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('config/upload/image',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /*------------------------------------------------ ?????? ----------------------------------------------------------*/

  /// ????????????????????????
  static Future<HttpResponse<FeedbackVO>> getFeedbackList({Map map}) async {
    String content = await HttpServe.get('feedback/list', map: map);
    HttpResponse<FeedbackVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(FeedbackVO.fromJson(item))});
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<FeedbackVO>> getFeedbackDetail({Map map}) async {
    String content = await HttpServe.get('feedback/detail', map: map);
    HttpResponse<FeedbackVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = FeedbackVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> submitFeedback({Map map}) async {
    String content = await HttpServe.get('feedback/clear', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-?????????????????????-???????????????
  static Future<HttpResponse<void>> feedbackDispatch({Map map}) async {
    String content = await HttpServe.get('feedback/dispatch', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????
  static Future<HttpResponse<TaskTempVO>> getWorkList({Map map}) async {
    String content = await HttpServe.get('taskTemp/list', map: map);
    HttpResponse<TaskTempVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(TaskTempVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<TaskVO>> getCleanerWorkList({Map map}) async {
    String content = await HttpServe.get('task/temp/list', map: map);
    HttpResponse<TaskVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(TaskVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<ItemVO>> getDateList({Map map}) async {
    String content = await HttpServe.get('config/list', map: map);
    HttpResponse<ItemVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(ItemVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<EmergencyVO>> getReportList({Map map}) async {
    String content = await HttpServe.get('emergency/list', map: map);
    HttpResponse<EmergencyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(EmergencyVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<EmergencyVO>> getReportDetail({Map map}) async {
    String content = await HttpServe.get('emergency/detail', map: map);
    HttpResponse<EmergencyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = EmergencyVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<MaterialApplyVO>> getMaterialApplyList(
      {Map map}) async {
    String content = await HttpServe.get('toolsApply/list', map: map);
    HttpResponse<MaterialApplyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(MaterialApplyVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<MessageVO>> getMessageList({Map map}) async {
    String content = await HttpServe.get('message/list', map: map);
    HttpResponse<MessageVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(MessageVO.fromJson(item));
    });
    return response;
  }

  /// ?????????????????? ???????????? ???????????? ????????????
  static Future<HttpResponse<OrgBranchVO>> getOrgBranchList({Map map}) async {
    String content = await HttpServe.get('feedback/orgBranch/list', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  static Future<HttpResponse<OrgBranchVO>> getConfigOrgBranchList(
      {Map map}) async {
    String content = await HttpServe.get('config/orgBranch/list', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-????????????
  static Future<HttpResponse<RemainingTimeVO>> getMaterialTime(
      {Map map}) async {
    String content = await HttpServe.get('toolsApply/remaining/time', map: map);
    HttpResponse<RemainingTimeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = RemainingTimeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<MaterialApplyVO>> getMaterialDetail(
      {Map map}) async {
    String content = await HttpServe.get('toolsApply/detail', map: map);
    HttpResponse<MaterialApplyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = MaterialApplyVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????(???????????????????????????)
  static Future<HttpResponse<ToolsCheckRecordVO>> getToolsCheckRecordList(
      {Map map}) async {
    String content = await HttpServe.get('toolsCheckRecord/list', map: map);
    HttpResponse<ToolsCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(ToolsCheckRecordVO.fromJson(item));
    });
    return response;
  }

  /// ??????-????????????
  static Future<HttpResponse<ToolsVO>> getMateriaSleelectList({Map map}) async {
    String content = await HttpServe.get('tools/list', map: map);
    HttpResponse<ToolsVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(ToolsVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????-??????
  static Future<HttpResponse<void>> submitMaterialApply(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('toolsApply/create', formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-????????????
  static Future<HttpResponse<void>> confirmMaterialApply({Map map}) async {
    String content = await HttpServe.get('toolsApply/received', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????(???????????????????????????)
  static Future<HttpResponse<ToolsCheckRecordVO>> toolsCheckRecordDetail(
      {Map map}) async {
    String content = await HttpServe.get('toolsCheckRecord/detail', map: map);
    HttpResponse<ToolsCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = ToolsCheckRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> submitReport({Map map}) async {
    String content = await HttpServe.get('emergency/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> submitEditReport({Map map}) async {
    String content = await HttpServe.get('emergency/dealWith', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<WorkOffApplyVO>> getLeaveApplyList(
      {Map map}) async {
    String content = await HttpServe.get('workOffApply/list', map: map);
    HttpResponse<WorkOffApplyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(WorkOffApplyVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<WorkOffApplyVO>> getLeaveApplyDetail(
      {Map map}) async {
    String content = await HttpServe.get('workOffApply/detail', map: map);
    HttpResponse<WorkOffApplyVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = WorkOffApplyVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<MessageVO>> getMessageDetail({Map map}) async {
    String content = await HttpServe.get('message/detail', map: map);
    HttpResponse<MessageVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = MessageVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> submitLeaveApply({Map map}) async {
    String content = await HttpServe.get('workOffApply/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????-????????????????????????
  static Future<HttpResponse<void>> auditLeaveApply({Map map}) async {
    String content = await HttpServe.get('workOffApply/audit', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-???????????????
  static Future<HttpResponse<void>> toolsCheckRecordSubmit({Map map}) async {
    String content = await HttpServe.get('toolsCheckRecord/audit', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-????????????????????????
  static Future<HttpResponse<void>> addOrgCheckRecordSubmit(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('orgCheckRecord/create',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  //--------------------------------------------- ???????????? ------------------------------------------------
  /// ????????????????????????
  static Future<HttpResponse<TaskRequestVO>> getTaskRequestList(
      {Map map}) async {
    String content = await HttpServe.get('taskRequest/list', map: map);
    HttpResponse<TaskRequestVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(TaskRequestVO.fromJson(item))});
    return response;
  }

  /// ????????????????????????-??????
  static Future<HttpResponse<TaskRequestVO>> getTaskRequestDetail(
      {Map map}) async {
    String content = await HttpServe.get('taskRequest/detail', map: map);
    HttpResponse<TaskRequestVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = TaskRequestVO.fromJson(response.dataMap);
    return response;
  }

  /// ?????????????????????????????????
  static Future<HttpResponse<AreaManagerHomeVO>> getAreaManagerHome(
      {Map map}) async {
    String content = await HttpServe.get('task/areaManager/home', map: map);
    HttpResponse<AreaManagerHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = AreaManagerHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????????????????
  static Future<HttpResponse<AreaManagerHomeVO>> getAttendanceRecord(
      {Map map}) async {
    String content = await HttpServe.get('attendanceRecord/org/info', map: map);
    HttpResponse<AreaManagerHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = AreaManagerHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<CleanerVO>> getCleanerDetail({Map map}) async {
    String content = await HttpServe.get('user/cleaner/detail', map: map);
    HttpResponse<CleanerVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = CleanerVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????+??????????????????
  static Future<HttpResponse<UserVO>> getCleanerList({Map map}) async {
    String content = await HttpServe.get('config/cleaner/list', map: map);
    HttpResponse<UserVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(UserVO.fromJson(item))});
    return response;
  }

  /// ????????????-??????????????????
  static Future<HttpResponse<ItemVO>> getWorkOffApplyTypeList({Map map}) async {
    String content = await HttpServe.get('workOffApply/type/list', map: map);
    HttpResponse<ItemVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(ItemVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<TaskVO>> getTaskVOList({Map map}) async {
    String content = await HttpServe.get('taskRequest/task/list', map: map);
    HttpResponse<TaskVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(TaskVO.fromJson(item))});
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<TaskVO>> getCheckTaskVOList({Map map}) async {
    String content = await HttpServe.get('task/list', map: map);
    HttpResponse<TaskVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(TaskVO.fromJson(item))});
    return response;
  }

  /// ????????????-??????(????????????)
  static Future<HttpResponse<void>> taskRequestCommit(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('taskRequest/commit',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????-??????
  static Future<HttpResponse<void>> taskEditCommit(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('task/edit', formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????-??????
  static Future<HttpResponse<void>> taskAddCommit(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('task/add', formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????-??????
  static Future<HttpResponse<void>> submitCleanerEdit(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('user/cleaner/edit', formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-?????????
  static Future<HttpResponse<OrgCheckRecordVO>> getOrgCheckRecordList(
      {Map map}) async {
    String content = await HttpServe.get('orgCheckRecord/info/list', map: map);
    HttpResponse<OrgCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach(
        (item) => {response.list.add(OrgCheckRecordVO.fromJson(item))});
    return response;
  }

  /// ??????????????????-??????
  static Future<HttpResponse<OrgCheckRecordVO>> getOrgCheckRecord(
      {Map map}) async {
    String content = await HttpServe.get('orgCheckRecord/list', map: map);
    HttpResponse<OrgCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = OrgCheckRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-?????????????????????????????????
  static Future<HttpResponse<OrgCheckConfigVO>> getOrgConfigList(
      {Map map}) async {
    String content =
        await HttpServe.get('orgCheckRecord/config/list', map: map);
    HttpResponse<OrgCheckConfigVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach(
        (item) => {response.list.add(OrgCheckConfigVO.fromJson(item))});
    return response;
  }

  /// ??????????????????-??????-??????
  static Future<HttpResponse<OrgCheckRecordVO>> getOrgCheckRecordDetail(
      {Map map}) async {
    String content = await HttpServe.get('orgCheckRecord/item/list', map: map);
    HttpResponse<OrgCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = OrgCheckRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-???????????????-????????????-?????????
  static Future<HttpResponse<void>> submitFeedbackCreate({Map map}) async {
    String content = await HttpServe.get('feedback/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-???????????????????????????
  static Future<HttpResponse<OrgToolsApplyInfoVO>> getToolsOrgBranchList(
      {Map map}) async {
    String content = await HttpServe.get('toolsApply/orgBranch/list', map: map);
    HttpResponse<OrgToolsApplyInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach(
        (item) => {response.list.add(OrgToolsApplyInfoVO.fromJson(item))});
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<UserVO>> getCleanerAssessRecordList(
      {Map map}) async {
    String content =
        await HttpServe.get('cleanerAssessRecord/cleaner/list', map: map);
    HttpResponse<UserVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList
        .forEach((item) => {response.list.add(UserVO.fromJson(item))});
    return response;
  }

  /// ????????????????????????????????????
  static Future<HttpResponse<OrgToolsApplyInfoVO>> getToolsOrgBranchDetail(
      {Map map}) async {
    String content =
        await HttpServe.get('toolsApply/orgBranch/detail', map: map);
    HttpResponse<OrgToolsApplyInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = OrgToolsApplyInfoVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????-???????????????????????????????????????
  static Future<HttpResponse<void>> toolsApplyEdit(
      {Object formData, Map map}) async {
    String content =
        await HttpServe.post('toolsApply/edit', formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> userCleanerCreate({Map map}) async {
    String content = await HttpServe.get('user/cleaner/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> taskRequestCancel({Map map}) async {
    String content = await HttpServe.get('taskRequest/cancel', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<void>> adviceFeedbackCreate({Map map}) async {
    String content = await HttpServe.get('adviceFeedback/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ???????????????
  static Future<HttpResponse<OrgTaskInfoVO>> getTaskHomeList({Map map}) async {
    String content = await HttpServe.get('task/home', map: map);
    HttpResponse<OrgTaskInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgTaskInfoVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<TaskVO>> getTaskDetail({Map map}) async {
    String content = await HttpServe.get('task/detail', map: map);
    HttpResponse<TaskVO> response = HttpResponse.fromJson(json.decode(content));
    response.data = TaskVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<CleanerAttendanceInfoVO>>
      getCleanerAssessRecordDetail({Map map}) async {
    String content =
        await HttpServe.get('cleanerAssessRecord/home/info', map: map);
    HttpResponse<CleanerAttendanceInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = CleanerAttendanceInfoVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<CleanerAttendanceInfoVO>> getCleanerWorkAttendance(
      {Map map}) async {
    String content =
        await HttpServe.get('attendanceRecord/clean/info', map: map);
    HttpResponse<CleanerAttendanceInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = CleanerAttendanceInfoVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<BankHomeVO>> getBankHomeData({Map map}) async {
    String content = await HttpServe.get('task/bank/home', map: map);
    HttpResponse<BankHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = BankHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<BranchAssessRecordVO>> getBranchAssessRecordDetail(
      {Map map}) async {
    String content = await HttpServe.get('branchAssessRecord/detail', map: map);
    HttpResponse<BranchAssessRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = BranchAssessRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????????????????????????? ??????
  static Future<HttpResponse<BranchAssessRecordVO>> branchAssessRecordAdd(
      {Map map}) async {
    String content = await HttpServe.get('branchAssessRecord/info', map: map);
    HttpResponse<BranchAssessRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = BranchAssessRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????????????????????????? ????????????
  static Future<HttpResponse<CleanerAssessRecordItemVO>> getCleanerScoreList(
      {Map map}) async {
    String content =
        await HttpServe.get('cleanerAssessRecord/config/list', map: map);
    HttpResponse<CleanerAssessRecordItemVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(CleanerAssessRecordItemVO.fromJson(item));
    });
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> submitBranchAssessRecord(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('branchAssessRecord/create',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????
  static Future<HttpResponse<BranchAssessRecordVO>> getBranchAssessRecordList(
      {Map map}) async {
    String content = await HttpServe.get('branchAssessRecord/list', map: map);
    HttpResponse<BranchAssessRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(BranchAssessRecordVO.fromJson(item));
    });
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> cleanerScoreSubmit(
      {Object formData, Map map}) async {
    String content = await HttpServe.post('cleanerAssessRecord/create',
        formData: formData, map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<void>> cleanerClockIn({Map map}) async {
    String content = await HttpServe.get('attendanceRecord/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ???????????????
  static Future<HttpResponse<CleanerHomeVO>> getCleanerHomeData(
      {Map map}) async {
    String content = await HttpServe.get('task/cleaner/home', map: map);
    HttpResponse<CleanerHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = CleanerHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<UserVO>> getMyUserInfo({Map map}) async {
    String content = await HttpServe.get('user/me', map: map);
    HttpResponse<UserVO> response = HttpResponse.fromJson(json.decode(content));
    response.data = UserVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<void>> cleanerFinish({Map map}) async {
    String content = await HttpServe.get('task/finish/taskItem', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????-??????????????????????????????
  static Future<HttpResponse<void>> materielAllCommit({Map map}) async {
    String content = await HttpServe.get('toolsApply/commit', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  ////------------------------------------------- ????????????

  /// ??????????????????
  static Future<HttpResponse<ProjectHomeVO>> getProjectHomeData(
      {Map map}) async {
    String content = await HttpServe.get('task/project/home', map: map);
    HttpResponse<ProjectHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = ProjectHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<OrgBranchVO>> getAllocationList({Map map}) async {
    String content =
        await HttpServe.get('organizationBranch/allocation/list', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<OrgBranchVO>> getAllocationDetail(
      {Map map}) async {
    String content =
        await HttpServe.get('organizationBranch/areaLeader/detail', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = OrgBranchVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> organizationBranchCommit({Map map}) async {
    String content = await HttpServe.get(
        'organizationBranch/allocation/areaLeader',
        map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????
  static Future<HttpResponse<AreaVO>> getAreaList({Map map}) async {
    String content = await HttpServe.get('config/area/list', map: map);
    HttpResponse<AreaVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(AreaVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<OrgCheckInfoVO>> getOrganizationBranchDetail(
      {Map map}) async {
    String content =
        await HttpServe.get('organizationBranch/checkInfo', map: map);
    HttpResponse<OrgCheckInfoVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = OrgCheckInfoVO.fromJson(response.dataMap);
    return response;
  }

  /// ?????????????????????
  static Future<HttpResponse<AreaLeaderAssessVO>> getCheckAssessmentDetail(
      {Map map}) async {
    String content = await HttpServe.get(
        'organizationBranch/areaLeaderAssessInfo',
        map: map);
    HttpResponse<AreaLeaderAssessVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = AreaLeaderAssessVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-????????????
  static Future<HttpResponse<BranchAssessRecordVO>>
      getCheckMonthAssessmentDetail({Map map}) async {
    String content =
        await HttpServe.get('organizationBranch/accessDetail', map: map);
    HttpResponse<BranchAssessRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = BranchAssessRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<UserVO>> getAccessUserList({Map map}) async {
    String content =
        await HttpServe.get('organizationBranch/accessUser/list', map: map);
    HttpResponse<UserVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(UserVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<AdviceFeedbackVO>> getAdviceFeedbackList(
      {Map map}) async {
    String content = await HttpServe.get('adviceFeedback/list', map: map);
    HttpResponse<AdviceFeedbackVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(AdviceFeedbackVO.fromJson(item));
    });
    return response;
  }

  /// ?????????????????????
  static Future<HttpResponse<AdviceFeedbackVO>> getAdviceFeedbackDetail(
      {Map map}) async {
    String content = await HttpServe.get('adviceFeedback/detail', map: map);
    HttpResponse<AdviceFeedbackVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = AdviceFeedbackVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> taskRequestCreate({Map map}) async {
    String content = await HttpServe.get('taskRequest/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ???????????????
  static Future<HttpResponse<RepairHomeVO>> getRepairHomeData({Map map}) async {
    String content = await HttpServe.get('equipment/repair/home', map: map);
    HttpResponse<RepairHomeVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = RepairHomeVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<ProjectVO>> getProjectAll({Map map}) async {
    String content = await HttpServe.get('equipment/project/all', map: map);
    HttpResponse<ProjectVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(ProjectVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<OrgBranchVO>> getOrgBranchAll({Map map}) async {
    String content = await HttpServe.get('equipment/orgBranch/all', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  /// ???????????????+???????????? + ??????(????????????) ????????????
  static Future<HttpResponse<EquipmentReportVO>> getEquipmentReportList(
      {Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentReport/list', map: map);
    HttpResponse<EquipmentReportVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(EquipmentReportVO.fromJson(item));
    });
    return response;
  }

  /// ????????????
  static Future<HttpResponse<EquipmentVO>> getEquipmentDetail({Map map}) async {
    String content = await HttpServe.get('equipment/detail', map: map);
    HttpResponse<EquipmentVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = EquipmentVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> equipmentReportCommit({Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentReport/create', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<EquipmentReportVO>> getEquipmentReportDetail(
      {Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentReport/detail', map: map);
    HttpResponse<EquipmentReportVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = EquipmentReportVO.fromJson(response.dataMap);
    return response;
  }

  /// ???????????? ????????????
  static Future<HttpResponse<OrgBranchVO>> getEquipmentOrgBranchList(
      {Map map}) async {
    String content = await HttpServe.get('equipment/orgBranch/list', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  /// ???????????? ??????????????????????????????
  static Future<HttpResponse<OrgBranchVO>> getEquipmentOrgBranchNoAllList(
      {Map map}) async {
    String content =
        await HttpServe.get('equipment/orgBranch/list/noAll', map: map);
    HttpResponse<OrgBranchVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(OrgBranchVO.fromJson(item));
    });
    return response;
  }

  /// ????????????
  static Future<HttpResponse<void>> equipmentReportEdit({Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentReport/edit', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????????????????????????????
  static Future<HttpResponse<EquipmentMaintainRecordVO>>
      getEquipmentMaintainRecordList({Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentMaintainRecord/list', map: map);
    HttpResponse<EquipmentMaintainRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(EquipmentMaintainRecordVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????????????????
  static Future<HttpResponse<void>> equipmentMaintainRecordCommit(
      {Map map}) async {
    String content = await HttpServe.get(
        'equipment/equipmentMaintainRecord/commit',
        map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????????????????-??????
  static Future<HttpResponse<EquipmentMaintainRecordVO>>
      getEquipmentMaintainRecordDetail({Map map}) async {
    String content = await HttpServe.get(
        'equipment/equipmentMaintainRecord/detail',
        map: map);
    HttpResponse<EquipmentMaintainRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = EquipmentMaintainRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ???????????? ??????
  static Future<HttpResponse<EquipmentScrapRecordVO>>
      getEquipmentScrapRecordList({Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentScrapRecord/list', map: map);
    HttpResponse<EquipmentScrapRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(EquipmentScrapRecordVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????-??????
  static Future<HttpResponse<EquipmentScrapRecordVO>>
      getEquipmentScrapRecordDetail({Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentScrapRecord/detail', map: map);
    HttpResponse<EquipmentScrapRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = EquipmentScrapRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ??????????????????-??????-??????
  static Future<HttpResponse<void>> equipmentScrapRecordCommit(
      {Map map}) async {
    String content =
        await HttpServe.get('equipment/equipmentScrapRecord/edit', map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ????????????????????????
  static Future<HttpResponse<PropertyCheckRecordVO>> getPropertyCheckRecordList(
      {Map map}) async {
    String content =
        await HttpServe.get('equipment/propertyCheckRecord/list', map: map);
    HttpResponse<PropertyCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(PropertyCheckRecordVO.fromJson(item));
    });
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<PropertyCheckRecordVO>>
      getPropertyCheckRecordDetail({Map map}) async {
    String content =
        await HttpServe.get('equipment/propertyCheckRecord/detail', map: map);
    HttpResponse<PropertyCheckRecordVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = PropertyCheckRecordVO.fromJson(response.dataMap);
    return response;
  }

  /// ????????????
  static Future<HttpResponse<PropertyCheckRecordItemVO>>
      getPropertyCheckRecordInfoList({Map map}) async {
    String content =
        await HttpServe.get('equipment/propertyCheckRecord/info', map: map);
    HttpResponse<PropertyCheckRecordItemVO> response =
        HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(PropertyCheckRecordItemVO.fromJson(item));
    });
    return response;
  }

  /// ????????????-??????
  static Future<HttpResponse<void>> propertyCheckRecordCommit(
      {Object formData, Map map}) async {
    String content = await HttpServe.post(
        'equipment/propertyCheckRecord/commit',
        formData: formData,
        map: map);
    HttpResponse<void> response = HttpResponse.fromJson(json.decode(content));
    return response;
  }

  /// ??????????????????
  static Future<HttpResponse<IndexTaskInfo>> taskIndexTaskInfo(
      {Map map}) async {
    String content = await HttpServe.get('task/indexTaskInfo', map: map);
    HttpResponse<IndexTaskInfo> response =
        HttpResponse.fromJson(json.decode(content));
    response.data = IndexTaskInfo.fromJson(response.dataMap);
    return response;
  }

  /// ????????????-??????????????????????????????
  static Future<HttpResponse<AreaVO>> getToolsApplyAreaList({Map map}) async {
    String content = await HttpServe.get('toolsApply/area/list', map: map);
    HttpResponse<AreaVO> response = HttpResponse.fromJson(json.decode(content));
    response.dataList.forEach((item) {
      response.list.add(AreaVO.fromJson(item));
    });
    return response;
  }
}

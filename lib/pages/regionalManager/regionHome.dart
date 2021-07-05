import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/areaManagerHomeVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkCleanDemand.dart';
import 'package:bank_clean_flutter/pages/check/checkFeedbackList.dart';
import 'package:bank_clean_flutter/pages/check/checkMaterielExamine.dart';
import 'package:bank_clean_flutter/pages/common/message/messageList.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/regionalManager/leaveApprovalList.dart';
import 'package:bank_clean_flutter/pages/regionalManager/regionMaterialArea.dart';
import 'package:bank_clean_flutter/pages/regionalManager/schedulingDemandList.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegionHome extends StatefulWidget {
  @override
  _RegionHomeState createState() => _RegionHomeState();
}

class _RegionHomeState extends State<RegionHome> with ComPageWidget {
  bool isLoading = false;
  AreaManagerHomeVO resData;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Center(
      child: Scaffold(
          backgroundColor: ColorUtil.color('#F5F6F9'),
          body: LoadingPage(
            isLoading: isLoading,
            child: resData != null
                ? RefreshIndicator(
                    color: ColorUtil.color('#CF241C'),
                    onRefresh: _getData,
                    child: Column(
                      children: <Widget>[
                        /// 背景头部
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "lib/images/check/check_home_bg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(56),
                                    left: ScreenUtil().setWidth(32)),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'lib/images/check/check_logo.png',
                                      width: ScreenUtil().setWidth(56),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(8)),
                                      child: Text('金洁士项目主管',
                                          style: TextStyle(
                                              color: ColorUtil.color('#ffffff'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(60),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(40)),
                                child: Row(
                                  children: <Widget>[
                                    /// 排班需求
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SchedulingDemandList(),
                                              )).then((data) {
                                            _getData();
                                          });
                                        },
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topEnd,
                                                  overflow: Overflow.visible,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'lib/images/check/check_home_tab1.png',
                                                      width: ScreenUtil()
                                                          .setWidth(64),
                                                    ),
                                                    Positioned(
                                                      left: ScreenUtil()
                                                          .setWidth(44),
                                                      top: ScreenUtil()
                                                          .setHeight(-18),
                                                      child: Offstage(
                                                        offstage: resData
                                                                .taskRequestCount ==
                                                            0,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3),
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            20))),
                                                          ),
                                                          child: Text(
                                                              '${resData.taskRequestCount}',
                                                              style: TextStyle(
                                                                  color: ColorUtil.color(
                                                                      '#CF241C'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              28),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text('排班需求',
                                                    style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#ffffff'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(26),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LeaveApprovalList(),
                                              )).then((data) {
                                            _getData();
                                          });
                                        },
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topEnd,
                                                  overflow: Overflow.visible,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'lib/images/check/check_home_tab2.png',
                                                      width: ScreenUtil()
                                                          .setWidth(64),
                                                    ),
                                                    Positioned(
                                                      left: ScreenUtil()
                                                          .setWidth(44),
                                                      top: ScreenUtil()
                                                          .setHeight(-18),
                                                      child: Offstage(
                                                        offstage: resData
                                                                .workOffApplyCount ==
                                                            0,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3),
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            20))),
                                                          ),
                                                          child: Text(
                                                              '${resData.workOffApplyCount}',
                                                              style: TextStyle(
                                                                  color: ColorUtil.color(
                                                                      '#CF241C'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              28),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text('请假审批',
                                                    style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#ffffff'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(26),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckFeedbackList(),
                                              )).then((data) {
                                            _getData();
                                          });
                                        },
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topEnd,
                                                  overflow: Overflow.visible,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'lib/images/check/check_home_tab3.png',
                                                      width: ScreenUtil()
                                                          .setWidth(64),
                                                    ),
                                                    Positioned(
                                                      left: ScreenUtil()
                                                          .setWidth(44),
                                                      top: ScreenUtil()
                                                          .setHeight(-18),
                                                      child: Offstage(
                                                        offstage: resData
                                                                .feedbackCount ==
                                                            0,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3),
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            20))),
                                                          ),
                                                          child: Text(
                                                              '${resData.feedbackCount}',
                                                              style: TextStyle(
                                                                  color: ColorUtil.color(
                                                                      '#CF241C'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              28),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text('清扫分配',
                                                    style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#ffffff'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(26),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// messageList
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MessageList(),
                                              )).then((data) {
                                            _getData();
                                          });
                                        },
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topEnd,
                                                  overflow: Overflow.visible,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'lib/images/check/check_home_tab4.png',
                                                      width: ScreenUtil()
                                                          .setWidth(64),
                                                    ),
                                                    Positioned(
                                                      left: ScreenUtil()
                                                          .setWidth(44),
                                                      top: ScreenUtil()
                                                          .setHeight(-18),
                                                      child: Offstage(
                                                        offstage: resData
                                                                .messageCount ==
                                                            0,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3),
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          3)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            20))),
                                                          ),
                                                          child: Text(
                                                              '${resData.messageCount}',
                                                              style: TextStyle(
                                                                  color: ColorUtil.color(
                                                                      '#CF241C'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              28),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text('消息通知',
                                                    style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#ffffff'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(26),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 内容
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0)),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// 物料审批
                                Offstage(
                                  offstage: !resData.toolsCheck,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegionMaterialArea(),
//                                              CheckMaterielExamine(),
                                          )).then((data) {
                                        _getData();
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(24)),
                                      child: Image.asset(
                                          'lib/images/check/banner1.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(24)),
                                  child: Row(
                                    children: <Widget>[
                                      /// 网点巡检
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
                                          Application.router.navigateTo(
                                              context,
                                              Routers.onlineInspectionAdd +
                                                  "?outletsId=0&outletsStr=''",
                                              transition:
                                                  TransitionType.inFromRight);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(12),
                                          ),
                                          child: Image.asset(
                                              'lib/images/check/check_tab2.png'),
                                        ),
                                      )),

                                      /// 清扫需求
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) =>
//                                            CheckCleanDemand(),
//                                      )).then((data) {
//                                    if (data == 'init') {
//                                      print('刷新data');
//                                    }
//                                  });
                                          Application.router.navigateTo(
                                            context,
                                            Routers.checkCleanDemand,
                                            transition:
                                                TransitionType.inFromRight,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(6),
                                              right: ScreenUtil().setWidth(6)),
                                          child: Image.asset(
                                              'lib/images/check/check_tab1.png'),
                                        ),
                                      )),

                                      /// 员工录入 employeeEntry
//                              Expanded(
//                                  child: GestureDetector(
//                                onTap: () {
//                                  Application.router.navigateTo(
//                                      context, Routers.employeeEntry+'?id=0&isAdd=0',
//                                      transition: TransitionType.inFromRight);
//                                },
//                                child: Container(
//                                  margin: EdgeInsets.only(
//                                    left: ScreenUtil().setWidth(12),
//                                  ),
//                                  child: Image.asset(
//                                      'lib/images/regionalManager/region_tab3.png'),
//                                ),
//                              ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(24)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// 今日工作任务
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (resData.allTaskCount > 0) {
                                              Application.router.navigateTo(
                                                  context, Routers.cleanerWork,
                                                  transition: TransitionType
                                                      .inFromRight);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(12)),
                                            padding: EdgeInsets.all(
                                              ScreenUtil().setWidth(32),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ScreenUtil()
                                                      .setWidth(8))),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: ScreenUtil()
                                                              .setHeight(20)),
                                                      child: Text(
                                                        '今日工作任务',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(24)),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: ScreenUtil()
                                                              .setHeight(20)),
                                                      child: Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                '${resData.finishTaskCount}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            56),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text:
                                                                '/${resData.allTaskCount}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            28),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#CF241C'))),
                                                      ])),
                                                    ),
                                                    Text(
                                                      '已完成/总计',
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(24),
                                                          color:
                                                              ColorUtil.color(
                                                                  '#939CA3')),
                                                    )
                                                  ],
                                                ),
                                                Offstage(
                                                  offstage:
                                                      resData.allTaskCount == 0,
                                                  child: Image.asset(
                                                    'lib/images/my/right_icon.png',
                                                    width: ScreenUtil()
                                                        .setWidth(32),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      /// 今日反馈处理
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(12)),
                                            padding: EdgeInsets.all(
                                              ScreenUtil().setWidth(32),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ScreenUtil()
                                                      .setWidth(8))),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(20)),
                                                  child: Text(
                                                    '今日反馈处理',
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(24)),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(20)),
                                                  child: Text.rich(
                                                      TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            '${resData.finishFeedbackCount}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(56),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#626262'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text:
                                                            '/${resData.allFeedbackCount}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(28),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#CF241C'))),
                                                  ])),
                                                ),
                                                Text(
                                                  '已完成/总计',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
                                                          '#939CA3')),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// 考勤详情
                                GestureDetector(
                                  onTap: () {
                                    Application.router.navigateTo(
                                        context, Routers.checkWorkAttendance,
                                        transition: TransitionType.inFromRight);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(24),
                                        bottom: ScreenUtil().setHeight(50)),
                                    padding: EdgeInsets.all(
                                      ScreenUtil().setWidth(32),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setWidth(8))),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('考勤详情',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                )),
                                            Row(
                                              children: <Widget>[
                                                Text('今日考勤',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#CF241C'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(27),
                                                    )),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: ScreenUtil()
                                                          .setWidth(8)),
                                                  width:
                                                      ScreenUtil().setWidth(20),
                                                  child: Image.asset(
                                                      'lib/images/check/check_right_icon.png'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(50)),
                                          child: Row(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
//                                          decoration: BoxDecoration(
//                                              shape: BoxShape.rectangle,
//                                              color: Colors.white,
//                                              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(500)),
//                                              boxShadow: [BoxShadow(
//                                                offset: Offset(0.0,15.0),
//                                                color: ColorUtil.color('#26A8150E'),//阴影默认颜色,不能与父容器同时设置color
//                                                blurRadius: ScreenUtil().setHeight(40.0),//延伸距离,会有模糊效果
//                                              )]
//                                          ),
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: ScreenUtil()
                                                          .setWidth(220),
                                                      //大小
                                                      lineWidth: ScreenUtil()
                                                          .setWidth(16),
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      //指示线条大小
                                                      percent: resData
                                                              .attendanceCount /
                                                          (resData.attendanceCount +
                                                              resData
                                                                  .allAttendanceCount),
                                                      //当前进度
                                                      center: Text(""),
                                                      //圆角截断
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round,
                                                      backgroundColor:
                                                          ColorUtil.color(
                                                              '#EDEEEF'),
                                                      progressColor:
                                                          ColorUtil.color(
                                                              '#CF241C'), //进度条颜色
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        10),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        8)),
                                                        child: Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text:
                                                                  '${resData.attendanceCount}/',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#CF241C'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          TextSpan(
                                                              text:
                                                                  '${resData.allAttendanceCount}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ])),
                                                      ),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text: '打卡/',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#CF241C'),
                                                            )),
                                                        TextSpan(
                                                            text: '应到',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#333333'),
                                                            )),
                                                      ]))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                  child: Container(
                                                child: Wrap(
                                                  runSpacing:
                                                      ScreenUtil().setWidth(30),
                                                  spacing:
                                                      ScreenUtil().setWidth(8),
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(0),
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      0)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(88),
                                                            child: Text(
                                                                '${resData.later}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              40),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                )),
                                                          ),
                                                          Text('迟到',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            24),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(0),
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      0)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(88),
                                                            child: Text(
                                                                '${resData.early}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              40),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                )),
                                                          ),
                                                          Text('早退',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            24),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(0),
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      0)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(88),
                                                            child: Text(
                                                                '${resData.lack}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              40),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                )),
                                                          ),
                                                          Text('缺卡',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            24),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(0),
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      0)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(88),
                                                            child: Text(
                                                                '${resData.workOffCount}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              40),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                )),
                                                          ),
                                                          Text('请假',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            24),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(0),
                                                              ScreenUtil()
                                                                  .setWidth(20),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      0)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(88),
                                                            child: Text(
                                                                '${resData.absenteeism}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              40),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                )),
                                                          ),
                                                          Text('旷工',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            24),
                                                                color: ColorUtil
                                                                    .color(
                                                                        '#333333'),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ))
                : Text(''),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  Future _getData() async {
    Api.getAreaManagerHome().then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }
}

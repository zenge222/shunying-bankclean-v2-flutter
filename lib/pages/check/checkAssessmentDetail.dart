import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/cleanerAttendanceInfoVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkAssessmentScoring.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckAssessmentDetail extends StatefulWidget {
  final int id;
  final String dateStr;

  const CheckAssessmentDetail({Key key, this.id, this.dateStr})
      : super(key: key);

  @override
  _CheckAssessmentDetailState createState() => _CheckAssessmentDetailState();
}

class _CheckAssessmentDetailState extends State<CheckAssessmentDetail>
    with ComPageWidget {
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  CleanerAttendanceInfoVO resData;
  bool isLoading = false;
  String type='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '保洁考核详情',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
          isLoading: isLoading,
          child: resData != null
              ? Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(40)),
                        child: Column(
                          children: <Widget>[
                            /// 头部信息
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24)),
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#ffffff'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    child: Image.network(
                                      '${resData.baseUrl + resData.profile}',
                                      width: ScreenUtil().setWidth(152),
                                      height: ScreenUtil().setHeight(152),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(20)),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(30)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('${resData.cleanerName}',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                )),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(0),
                                                  ScreenUtil().setHeight(16),
                                                  ScreenUtil().setWidth(0),
                                                  ScreenUtil().setHeight(16)),
                                              padding: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(10),
                                                  ScreenUtil().setHeight(2),
                                                  ScreenUtil().setWidth(10),
                                                  ScreenUtil().setHeight(2)),
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorUtil.color('#F2F2F2'),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(ScreenUtil()
                                                        .setWidth(8))),
                                              ),
                                              child: Text(
                                                  '${resData.orgBranchName}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#666666'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(28),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(8)),
                                                  child: Image.asset(
                                                    'lib/images/call_phone_icon.png',
                                                    width: ScreenUtil()
                                                        .setWidth(32),
                                                  ),
                                                ),
                                                Text('${resData.phone}',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#666666'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(28),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Offstage(
                                          offstage: resData.startWorkTime == "",
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${resData.startWorkTime}-${resData.endWorkTime}',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize:
                                                      ScreenUtil().setSp(28),
                                                )),
                                          ])),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),

                            /// 选择事件
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24)),
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(28)),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Column(
                                children: <Widget>[
                                  /// 事件时间
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(218),
                                        height: ScreenUtil().setHeight(2),
                                        color: ColorUtil.color('#F4F4F4'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DateTime today = DateTime.now();
                                          ResetPicker.showDatePicker(context,
                                              value: currentDate,
                                              dateType: DateType.YM,
                                              minValue:
                                                  DateTime(today.year - 1),
                                              maxValue: DateTime(today.year + 1,
                                                  today.month, today.day),
                                              clickCallback:
                                                  (var str, var time) {
                                            setState(() {
                                              currentTime = str;
                                              currentDate =
                                                  DateTime.parse(time);
                                            });
                                            _getData();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(28),
                                              ScreenUtil().setHeight(8),
                                              ScreenUtil().setWidth(28),
                                              ScreenUtil().setHeight(8)),
                                          decoration: BoxDecoration(
                                            color: ColorUtil.color('#F4F4F4'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setWidth(22))),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '${currentTime}',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(28)),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: ScreenUtil()
                                                        .setWidth(4)),
                                                width:
                                                    ScreenUtil().setWidth(24),
                                                child: Image.asset(
                                                    'lib/images/clean/triangle_down.png'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(218),
                                        height: ScreenUtil().setHeight(2),
                                        color: ColorUtil.color('#F4F4F4'),
                                      ),
                                    ],
                                  ),

                                  /// 考核记录
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(64),
                                        left: ScreenUtil().setHeight(26)),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '${resData.accessScore == 0 ? '--' : resData.accessScore}',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#CF241C'),
                                                  fontSize:
                                                      ScreenUtil().setSp(48),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '月度考核分',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(28)),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setHeight(20)),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.workDayCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '出勤天数',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.workTimeCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '工时',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.workOffCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '请假数',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.feedbackCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '反馈',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),

                                  /// 圆形统计
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(40)),
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
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
                                                              .taskFinish /
                                                          (resData.taskFinish +
                                                              resData
                                                                  .taskUnFinish),
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
                                                                  '${resData.taskFinish}/',
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
                                                                  '${resData.taskUnFinish}',
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
                                                            text: '已完成/',
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
                                                            text: '未完成',
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
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setWidth(26)),
                                                child: Text('保洁任务完成度',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(40)),
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
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
                                                      percent: resData.onTime /
                                                          (resData.onTime +
                                                              resData.outTime),
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
                                                              '#D5A785'), //进度条颜色
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
                                                                  '${resData.onTime}/',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#CD8E5F'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          TextSpan(
                                                              text:
                                                                  '${resData.outTime}',
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
                                                            text: '准时/',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#CD8E5F'),
                                                            )),
                                                        TextSpan(
                                                            text: '超时',
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
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setWidth(26)),
                                                child: Text('反馈处理准时度',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(72),
                                        bottom: ScreenUtil().setHeight(40)),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${resData.later}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '迟到',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(22)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${resData.early}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '早退',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(22)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${resData.lack}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '缺卡',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(22)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${resData.absenteeism}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '旷工',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(22)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /// table
                            Offstage(
                              offstage: resData.attendanceVOList.length == 0,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(24)),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                ),
                                child: Column(
                                  children: _buildTable(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                   Offstage(
                     offstage: type=='5',
                     child:  Container(
                       width: double.infinity,
                       color: Colors.white,
                       padding: EdgeInsets.fromLTRB(
                           ScreenUtil().setWidth(80),
                           ScreenUtil().setHeight(16),
                           ScreenUtil().setWidth(80),
                           ScreenUtil().setHeight(16)),
                       child: FlatButton(
                         padding: EdgeInsets.fromLTRB(
                             ScreenUtil().setWidth(0),
                             ScreenUtil().setHeight(20),
                             ScreenUtil().setWidth(0),
                             ScreenUtil().setHeight(20)),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(
                                 ScreenUtil().setWidth(60))),
                         color: ColorUtil.color('#CF241C'),
                         child: Text('月考核打分',
                             style: TextStyle(
                               color: ColorUtil.color('#ffffff'),
                               fontWeight: FontWeight.bold,
                               fontSize: ScreenUtil().setSp(32),
                             )),
                         onPressed: () {
                           if (resData.accessScore == 0) {
                             print('resData.accessScore:' +
                                 resData.accessScore.toString());
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => CheckAssessmentScoring(
                                       id: widget.id, dateStr: currentTime),
                                 )).then((data) {
                               if (data == 'init') {
                                 _getData();
                               }
                             });
                           } else {
                             Application.router.navigateTo(
                                 context,
                                 Routers.checkAssessmentScored +
                                     '?id=${widget.id}&dateStr=${currentTime}',
                                 transition: TransitionType.inFromRight);
                           }
                         },
                       ),
                     ),
                   ),
                  ],
                )
              : Text('')),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      currentTime = widget.dateStr;
    });
    _getData();
  }

  Future _getData() async {
    String appType = await SharedPreferencesUtil.getType();
    Map params = new Map();
    params['cleanerId'] = widget.id;
    params['dateStr'] = currentTime;
    Api.getCleanerAssessRecordDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          type = appType;
          isLoading = false;
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _buildTable() {
    List<Widget> list = [];

    /// 头部
    list.add(Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: ScreenUtil().setWidth(1),
                  color: ColorUtil.color('#EAEAEA')))),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(30),
          ScreenUtil().setHeight(20),
          ScreenUtil().setWidth(0),
          ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(220),
            child: Text(
              '日期',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.color('#333333')),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(260),
            child: Text(
              '考勤时间',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.color('#333333')),
            ),
          ),
          Expanded(
              child: Text(
            '状态',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.bold,
                color: ColorUtil.color('#333333')),
          ))
        ],
      ),
    ));

    /// 内容
    resData.attendanceVOList.forEach((val) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: ScreenUtil().setWidth(1),
                    color: ColorUtil.color('#EAEAEA')))),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(20),
            ScreenUtil().setWidth(0),
            ScreenUtil().setHeight(20)),
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(220),
              child: Text(
                '${val.createTime}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: ColorUtil.color('#333333')),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(260),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '${val.firstTime==null?'':val.firstTime}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: ColorUtil.color(
                          val.firstStatus != 4 ? '#CF241C' : '#333333'),
                    )),
                TextSpan(
                    text: '~',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: ColorUtil.color('#333333'),
                    )),
                TextSpan(
                    text: '${val.secondTime==null?'':val.secondTime}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: ColorUtil.color(
                          val.secondStatus != 4 ? '#CF241C' : '#333333'),
                    )),
              ])),
            ),
            Expanded(
                child: Text(
              _getString(val.firstStatus, val.secondStatus, val.firstStatusText,
                  val.secondStatusText),
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: ColorUtil.color(
                      (val.firstStatusText != 4 || val.secondStatus != 4)
                          ? '#CF241C'
                          : '#333333')),
            ))
          ],
        ),
      ));
    });
    return list;
  }

  String _getString(int firstStatus, int secondStatus, String firstStatusText,
      String secondStatusText) {
    String str = '';
    if (firstStatus != 4 && secondStatus != 4) {
      str = firstStatusText + '、' + secondStatusText;
    }
    if (firstStatus == 4 && secondStatus == 4) {
      str = firstStatusText;
    }
    if (firstStatus != 4 && secondStatus == 4) {
      str = firstStatusText;
    }
    if (firstStatus == 4 && secondStatus != 4) {
      str = secondStatusText;
    }
    return str;
  }
}

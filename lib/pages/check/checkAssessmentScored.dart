import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/cleanerAssessRecordItemVO.dart';
import 'package:bank_clean_flutter/models/cleanerAttendanceInfoVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckAssessmentScored extends StatefulWidget {
  final int id;
  final String dateStr;

  const CheckAssessmentScored({Key key, this.id, this.dateStr})
      : super(key: key);

  @override
  _CheckAssessmentScoredState createState() => _CheckAssessmentScoredState();
}
/// 已打分
class _CheckAssessmentScoredState extends State<CheckAssessmentScored>
    with ComPageWidget {
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  CleanerAttendanceInfoVO resData;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '保洁考核打分',
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
          isLoading: false,
          child: resData != null
              ? Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(24),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(40)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
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
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${resData.workDayCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '出勤天数',
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
                                                  '${resData.workTimeCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '工时',
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
                                                  '${resData.workOffCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '请假数',
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
                                                  '${resData.feedbackCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '反馈',
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
                                                              text: '${resData.taskFinish}/',
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
                                                              text: '${resData.taskUnFinish}',
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
                                                              text:'${resData.onTime}/',
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
                                                              text:  '${resData.outTime}',
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
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(50),
                                  bottom: ScreenUtil().setHeight(50)),
                              child: Text('打分情况',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(36),
                                  )),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Column(
                                children: _scoreListBuild(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(28),
                          ScreenUtil().setHeight(16),
                          ScreenUtil().setWidth(28),
                          ScreenUtil().setHeight(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('最终得分：'),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '${resData.accessScore}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#CF241C'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(48),
                                    )),
                                TextSpan(
                                    text: '分',
                                    style: TextStyle(
                                      color: ColorUtil.color('#CF241C'),
                                      fontSize: ScreenUtil().setSp(24),
                                    )),
                              ])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Text('')
//        SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              Text('asd'),
//              Expanded(child: Text('asd')),
//              Text('asd'),
//            ],
//          ),
//        ),
          ),
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
    print('已打分');
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['cleanerId'] = widget.id;
    params['dateStr'] = currentTime;
    Api.getCleanerAssessRecordDetail(map: params).then((res) {
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

  List<Widget> _scoreListBuild(BuildContext context) {
    List<Widget> list =[];
    List<CleanerAssessRecordItemVO> resList = resData.cleanerAssessRecordItemVOList;
    for(int i=0;i<resList.length;i++){
      list.add(Container(
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(40),
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(40)),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: ScreenUtil().setWidth(1),
                  color: ColorUtil.color(
                      '#EAEAEA'))),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text('${i+1}.${resList[i].title}',
                    style: TextStyle(
                      color: ColorUtil.color(
                          '#333333'),
                      fontSize:
                      ScreenUtil().setSp(28),
                    ))),
            Text('${resList[i].score}',style: TextStyle(
                fontSize:
                ScreenUtil().setSp(36),
                fontWeight: FontWeight.bold)),
            Text(
              ' 分',
              style: TextStyle(
                  fontSize:
                  ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));
    }
    return list;
  }
}

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

class CheckAssessmentScoring extends StatefulWidget {
  final int id;
  final String dateStr;

  const CheckAssessmentScoring({Key key, this.id, this.dateStr})
      : super(key: key);

  @override
  _CheckAssessmentScoringState createState() => _CheckAssessmentScoringState();
}

/// 未打分
class _CheckAssessmentScoringState extends State<CheckAssessmentScoring>
    with ComPageWidget {
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  CleanerAttendanceInfoVO resData;
  bool isLoading = false;
  List<CleanerAssessRecordItemVO> scoreList = [];
  double average = 0.0;

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
                                children: _scoreBuild(context),
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
                                    text: '${average}',
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
                          Container(
                            width: ScreenUtil().setWidth(200),
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
                              child: Text('提交',
                                  style: TextStyle(
                                    color: ColorUtil.color('#ffffff'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                _scoreSubmit();
                              },
                            ),
                          )
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
    print('未打分');
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['cleanerId'] = widget.id;
    params['dateStr'] = currentTime;
    Api.getCleanerAssessRecordDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          resData = res.data;
        });
        _getScoreList();
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getScoreList() async {
    Api.getCleanerScoreList().then((res) {
      if (res.code == 1) {
        double d1 = 0.0;
        res.list.forEach((val) {
          d1 += val.score;
        });
        setState(() {
          isLoading = false;
          scoreList = res.list;
        });
        double ave = d1 / scoreList.length;
        String piStr = ave.toStringAsFixed(1);
        setState(() {
          average = double.parse(piStr);
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _scoreSubmit() async{
    Map params = new Map();
    params['cleanerId'] = widget.id;
    params['dateStr'] = currentTime;
    Api.cleanerScoreSubmit(map: params,formData: scoreList).then((res){
      if(res.code==1){
        Navigator.pop(context,'init');
      }
      showToast(res.msg);
    });
  }

  List<Widget> _scoreBuild(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < scoreList.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
          ResetPicker.showStringPicker(context,
              data: list,
              normalIndex: 0,
              title: "选择分数", clickCallBack: (int index, var str) {
            String stringNum = str.toString() + '.0';

            setState(() {
              scoreList[i].score = double.parse(stringNum);
            });
            double d1 = 0.0;
            scoreList.forEach((val) {
              d1 += val.score;
              print(d1);
            });
            double ave = d1 / scoreList.length;
            String piStr = ave.toStringAsFixed(1);
            setState(() {
              average = double.parse(piStr);
            });
//                average
          });
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(30),
              ScreenUtil().setHeight(40),
              ScreenUtil().setWidth(30),
              ScreenUtil().setHeight(40)),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: ScreenUtil().setWidth(1),
                    color: ColorUtil.color('#EAEAEA'))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text('${i + 1}.${scoreList[i].title}',
                      style: TextStyle(
                        color: ColorUtil.color('#333333'),
                        fontSize: ScreenUtil().setSp(28),
                      ))),
              Container(
                width: ScreenUtil().setWidth(132),
                height: ScreenUtil().setHeight(56),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD1D1D1)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(70),
                      child: Text('${scoreList[i].score~/1}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(28),
                          )),
                      alignment: Alignment.center,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(56),
                          height: ScreenUtil().setHeight(56),
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),
                            border: Border(
                                left: BorderSide(color: Color(0xffD1D1D1))),
                          ),
                        ),
                        Positioned(
                            left: ScreenUtil().setWidth(15),
                            height: ScreenUtil().setHeight(50),
                            child: Image.asset(
                              'lib/images/to_score_icon.png',
                              width: ScreenUtil().setWidth(24),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                ' 分',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }


}

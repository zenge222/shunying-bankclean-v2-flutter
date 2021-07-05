import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/cleanerAttendanceInfoVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanWorkRecord extends StatefulWidget {
  @override
  _CleanWorkRecordState createState() => _CleanWorkRecordState();
}

class _CleanWorkRecordState extends State<CleanWorkRecord> with ComPageWidget {
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  bool isLoading = false;
  CleanerAttendanceInfoVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '考勤记录',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        brightness: Brightness.light,
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: resData != null
          ? SingleChildScrollView(
              child: LoadingPage(
                isLoading: isLoading,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(0),
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        dateType: DateType.YM,
                                        value: currentDate,
                                        minValue: DateTime(today.year - 1),
                                        maxValue: DateTime(today.year + 1,
                                            today.month, today.day),
                                        clickCallback: (var str, var time) {
                                      setState(() {
                                        currentDate = DateTime.parse(time);
                                        currentTime = str;
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
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(28)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(4)),
                                          width: ScreenUtil().setWidth(24),
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

                            /// 打卡记录
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(64)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '${resData.workDayCount}',
                                          style: TextStyle(
                                              color: ColorUtil.color('#CF241C'),
                                              fontSize: ScreenUtil().setSp(48),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '出勤天数',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(28)),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '${resData.workTimeCount}',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(48),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '工时',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(28)),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '${resData.workOffCount}',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(48),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '请假数',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(28)),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(50)),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: ColorUtil.color('#EEEEEE'),
                                    width: ScreenUtil().setWidth(1),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorUtil.color('#F2F2F2'),
                                              width: 1.0,
                                            ),
                                            right: BorderSide(
                                              color: ColorUtil.color('#F2F2F2'),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22),
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '迟到',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                            Text(
                                              '${resData.later}次',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22),
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22)),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                              color: ColorUtil.color('#F2F2F2'),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '缺卡',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                            Text(
                                              '${resData.lack}次',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorUtil.color('#F2F2F2'),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22),
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '早退',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                            Text(
                                              '${resData.early}次',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22),
                                            ScreenUtil().setWidth(30),
                                            ScreenUtil().setHeight(22)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '旷工',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                            Text(
                                              '${resData.absenteeism}次',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
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
              ),
            )
          : Text(''),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTime = new DateTime.now();
    setState(() {
      isLoading = true;
      currentTime =
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}';
    });
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['dateStr'] = currentTime;
    Api.getCleanerWorkAttendance(map: params).then((res) {
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

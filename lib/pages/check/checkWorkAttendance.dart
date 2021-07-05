import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/areaManagerHomeVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckWorkAttendance extends StatefulWidget {
  @override
  _CheckWorkAttendanceState createState() => _CheckWorkAttendanceState();
}

/// 区域经理
class _CheckWorkAttendanceState extends State<CheckWorkAttendance>
    with ComPageWidget {
  int orgBranchId = 0;
  bool isLoading = false;
  String orgBranchStr = '';
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  AreaManagerHomeVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '考勤',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        // 默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: resData != null
                ? Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0)),
                    child: Column(
                      children: <Widget>[
                        /// 选择
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(24),
                              ScreenUtil().setHeight(36),
                              ScreenUtil().setWidth(24),
                              ScreenUtil().setHeight(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OutletsSelect(type: 2),
                                      )).then((data) {
                                    if (data != null) {
                                      print('改变数据');
                                      setState(() {
                                        orgBranchId = data.id;
                                        orgBranchStr = data.name;
                                      });
                                      _getData();
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(24),
                                      ScreenUtil().setHeight(10),
                                      ScreenUtil().setWidth(12),
                                      ScreenUtil().setHeight(10)),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.color('#ffffff'),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(26))),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text('${orgBranchStr}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(28),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(8)),
                                        child: Image.asset(
                                          'lib/images/sel_picker.png',
                                          width: ScreenUtil().setWidth(28),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  /// 日期选择器
                                  ResetPicker.showDatePicker(context,
                                      dateType: DateType.YMD,
//                                      minValue: currentDate,
                                      maxValue: DateTime.now(),
                                      value: currentDate,
                                      clickCallback: (var str, var time) {
                                    setState(() {
                                      currentTime = str;
                                      currentDate = DateTime.parse(time);
                                    });
                                    _getData();
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(24),
                                      ScreenUtil().setHeight(10),
                                      ScreenUtil().setWidth(12),
                                      ScreenUtil().setHeight(10)),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.color('#ffffff'),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(26))),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text('${currentTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(28),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(8)),
                                        child: Image.asset(
                                          'lib/images/sel_picker.png',
                                          width: ScreenUtil().setWidth(28),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 打卡记录
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
                          ),
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(32),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(50)),
                                child: Row(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: CircularPercentIndicator(
                                            radius: ScreenUtil().setWidth(220),
                                            //大小
                                            lineWidth:
                                                ScreenUtil().setWidth(16),
                                            animation: true,
                                            animationDuration: 1000,
                                            //指示线条大小
                                            percent: resData.attendanceCount /
                                                (resData.allAttendanceCount <
                                                        resData.attendanceCount
                                                    ? resData.attendanceCount
                                                    : resData
                                                        .allAttendanceCount),
                                            //当前进度
                                            center: Text(""),
                                            //圆角截断
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            backgroundColor:
                                                ColorUtil.color('#EDEEEF'),
                                            progressColor: ColorUtil.color(
                                                '#CF241C'), //进度条颜色
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(0),
                                                  ScreenUtil().setHeight(10),
                                                  ScreenUtil().setWidth(0),
                                                  ScreenUtil().setHeight(8)),
                                              child:
                                                  Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        '${resData.attendanceCount}/',
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(36),
                                                        color: ColorUtil.color(
                                                            '#CF241C'),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        '${resData.allAttendanceCount}',
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(36),
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ])),
                                            ),
                                            Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text: '打卡/',
                                                  style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(20),
                                                    color: ColorUtil.color(
                                                        '#CF241C'),
                                                  )),
                                              TextSpan(
                                                  text: '应到',
                                                  style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(20),
                                                    color: ColorUtil.color(
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
                                        runSpacing: ScreenUtil().setWidth(30),
                                        spacing: ScreenUtil().setWidth(8),
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0)),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      ScreenUtil().setWidth(88),
                                                  child: Text(
                                                      '${resData.later}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ),
                                                Text('迟到',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0)),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      ScreenUtil().setWidth(88),
                                                  child: Text(
                                                      '${resData.early}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ),
                                                Text('早退',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0)),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      ScreenUtil().setWidth(88),
                                                  child: Text('${resData.lack}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ),
                                                Text('缺卡',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0)),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      ScreenUtil().setWidth(88),
                                                  child: Text(
                                                      '${resData.workOffCount}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ),
                                                Text('请假',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(20),
                                                ScreenUtil().setHeight(0)),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      ScreenUtil().setWidth(88),
                                                  child: Text(
                                                      '${resData.absenteeism}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ),
                                                Text('旷工',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                      color: ColorUtil.color(
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

                        /// table
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              bottom: ScreenUtil().setHeight(50)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Column(
                            children: _buildTable(),
                          ),
                        )
                      ],
                    ),
                  )
                : Text(''),
          )),
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
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}-${dateTime.day > 10 ? dateTime.day : ('0' + dateTime.day.toString())}';
    });
    _getBranchList();
  }

  /// 通过网点列表 获取第一个网点
  Future _getBranchList() async {
    Map params = new Map();
    params['pageNo'] = 1;
    params['pageSize'] = 10;
    params['type'] = 2;
    params['searchWord'] = '';
    Api.getConfigOrgBranchList(map: params).then((res) {
      if (res.code == 1) {
        if(res.list.length>0){
          setState(() {
            orgBranchId = res.list[0].id;
            orgBranchStr = res.list[0].name;
          });
        }

        print('orgBranchId:' + orgBranchId.toString());
        _getData();
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getData() async {
    Map params = new Map();
    params['dateStr'] = currentTime;
    params['orgBranchId'] = orgBranchId;
    Api.getAttendanceRecord(map: params).then((res) {
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
            width: ScreenUtil().setWidth(150),
            child: Text(
              '姓名',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.color('#333333')),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(152),
            child: Text(
              '网点',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.color('#333333')),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
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
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(2)),
              width: ScreenUtil().setWidth(150),
              child: Text(
                '${val.cleanerName}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: ColorUtil.color('#333333')),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(152),
              child: Text(
                '${val.organizationBranchName}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: ColorUtil.color('#333333')),
              ),
            ),
            Container(
                width: ScreenUtil().setWidth(180),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('${val.firstTime == null ? '' : val.firstTime}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: ColorUtil.color(
                              val.firstStatus != 4 ? '#CF241C' : '#333333'),
                        )),
                    Text('~',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: ColorUtil.color('#333333'),
                        )),
                    Text('${val.secondTime == null ? '' : val.secondTime}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: ColorUtil.color(
                              val.secondStatus != 4 ? '#CF241C' : '#333333'),
                        )),
                  ],
                )
//              Text.rich(TextSpan(children: [
//                TextSpan(
//                    text: '${val.firstTime == null ? '' : val.firstTime}',
//                    style: TextStyle(
//                      fontSize: ScreenUtil().setSp(28),
//                      color: ColorUtil.color(
//                          val.firstStatus != 4 ? '#CF241C' : '#333333'),
//                    )),
//                TextSpan(
//                    text: '~',
//                    style: TextStyle(
//                      fontSize: ScreenUtil().setSp(28),
//                      color: ColorUtil.color('#333333'),
//                    )),
//                TextSpan(
//                    text: '${val.secondTime == null ? '' : val.secondTime}',
//                    style: TextStyle(
//                      fontSize: ScreenUtil().setSp(28),
//                      color: ColorUtil.color(
//                          val.secondStatus != 4 ? '#CF241C' : '#333333'),
//                    )),
//              ])),
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
      if(secondStatusText==""){
        str = firstStatusText;
      }else{
        str = firstStatusText + '、' + secondStatusText;
      }
    }
    if (firstStatus == 3 && secondStatus == 3) {
      str = '旷工';
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

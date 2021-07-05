import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgTaskInfoVO.dart';
import 'package:bank_clean_flutter/models/taskVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkAddScheduling.dart';
import 'package:bank_clean_flutter/pages/check/checkSchedulingEdit.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckScheduling extends StatefulWidget {
  @override
  _CheckSchedulingState createState() => _CheckSchedulingState();
}

/// 巡检+区域经理
class _CheckSchedulingState extends State<CheckScheduling> with ComPageWidget {
  List weeks = ["一", "二", "三", "四", "五", "六", "日"];
  int orgBranchId = 0;
  String orgBranchStr = '';
  bool isLoading = false;
  String dateStr = '';
  DateTime currentDate = DateTime.now();
  List<OrgTaskInfoVO> resList = [];
  List<TaskVO> planList = [];
  int currentDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '排班',
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
          child: Container(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      /// sel
                      Container(
                        margin: EdgeInsets.all(ScreenUtil().setWidth(32)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OutletsSelect(type: 3),
                                    )).then((data) {
                                  if (data != null) {
                                    print('改变数据');
                                    setState(() {
                                      currentDay = 0;
                                      orgBranchId = data.id;
                                      orgBranchStr = data.name;
                                      planList = [];
                                    });
                                    _getDataList();
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'lib/images/check/check_logo.png',
                                    width: ScreenUtil().setWidth(60),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(8)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: ScreenUtil().setWidth(360),
                                      ),
                                      child: Text('${orgBranchStr}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(0)),
                                    child: Image.asset(
                                      'lib/images/sel_picker.png',
                                      width: ScreenUtil().setWidth(36),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      ResetPicker.showDatePicker(context,
                                          value: currentDate,
                                          dateType: DateType.YM,
//                            minValue: DateTime(today.year - 1),
//                            maxValue: DateTime(today.year + 1,today.month,today.day),
                                          title: '选择日期',
                                          clickCallback: (timeStr, time) {
                                        setState(() {
                                          dateStr = timeStr;
                                          currentDate = DateTime.parse(time);
                                          planList = [];
                                        });
                                        _getDataList();
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
                                          Text('${dateStr}',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(28),
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
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(32),
                              bottom: ScreenUtil().setWidth(40),
                              right: ScreenUtil().setWidth(32)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// 日历
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(40),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(40)),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(20)),
                                        child: Wrap(
                                            spacing: ScreenUtil().setWidth(38),
                                            //主轴上子控件的间距
                                            runSpacing:
                                            ScreenUtil().setHeight(38),
                                            //交叉轴上子控件之间的间距
                                            children: _buildWeeks(context)),
                                      ),
                                      Wrap(
                                          spacing: ScreenUtil().setWidth(38),
                                          //主轴上子控件的间距
                                          runSpacing: ScreenUtil().setHeight(38),
                                          //交叉轴上子控件之间的间距
                                          children: _buildDays(context))
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(60)),
                                child: Text('排班情况 ',
                                    style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(36),
                                    )),
                              ),
                              Column(
                                children: _planBuild(context),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                  Positioned(
                    bottom: ScreenUtil().setHeight(20),
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        String date = "";
                        if (currentDay != 0) {
                          date = dateStr +
                              '-' +
                              (currentDay >= 10
                                  ? currentDay.toString()
                                  : '0' + currentDay.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckAddScheduling(
                                date: date,
                                outId: orgBranchId,
                                outStr: orgBranchStr
                              ),
                            )).then((data) {
                          if (data == "init") {
                            print('刷新list');
                            setState(() {
                              currentDay = 0;
                              planList = [];
                            });
                            _getDataList();
                          }
                        });
                      },
                      child: Image.asset('lib/images/check/add_scheduling.png'),
                    ),
                    width: ScreenUtil().setWidth(144),
                  ),
                ],
              ))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTime = new DateTime.now();
    setState(() {
      isLoading = true;
      dateStr =
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}';
    });
    _getBranchList();
  }

  /// 通过网点列表 获取第一个网点
  Future _getBranchList() async {
    Map params = new Map();
    params['pageNo'] = 1;
    params['pageSize'] = 10;
    params['type'] = 3;
    params['searchWord'] = '';
    Api.getConfigOrgBranchList(map: params).then((res) {
      if (res.code == 1) {
        if(res.list.length>0){
          setState(() {
            orgBranchId = res.list[0].id;
            orgBranchStr = res.list[0].name;
          });
        }
        _getDataList();
        print('orgBranchId:' + orgBranchId.toString());
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getDataList() async {
    Map params = new Map();
    params['dateStr'] = dateStr;
    params['orgBranchId'] = orgBranchId;
    List<OrgTaskInfoVO> list = [];
    Api.getTaskHomeList(map: params).then((res) {
      if (res.code == 1) {
        /// 获取当前月第一天星期
        int weekDay = DateTime(int.parse(dateStr.split('-')[0]), int.parse(dateStr.split('-')[1]), 1).weekday;
        for (int i = 1; i < weekDay; i++) {
          OrgTaskInfoVO dateItem = new OrgTaskInfoVO();
          dateItem.select = false;
          dateItem.date = '';
          dateItem.status = 0;
          dateItem.id = 0;
          dateItem.taskList = [];
          list.add(dateItem);
        }
        list.addAll(res.list);
        setState(() {
          resList = list;
          isLoading = false;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _buildDays(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < resList.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          if(resList[i].status==0) return;
          resList.forEach((val) {
            val.select = false;
          });
          setState(() {
            resList[i].select = true;
            planList = resList[i].taskList;
            currentDay = resList[i].id;
//            resList[i].id >= 10
//                ? resList[i].id.toString()
//                : '0${resList[i].id}';
          });
        },
        child: Container(
          width: ScreenUtil().setWidth(56), // 56
          height: ScreenUtil().setHeight(56), // 53
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain, // 将会尽可能的伸展来达到组件的边缘
              image: AssetImage(resList[i].select
                  ? 'lib/images/check/date3.png'
                  : (resList[i].taskList.length > 0
                      ? 'lib/images/check/date2.png'
                      : 'lib/images/check/date1.png')),
            ),
          ),
          child: Center(
            child: Text(
              '${resList[i].id==0?'':resList[i].id}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30),
                  color: ColorUtil.color(resList[i].select
                      ? '#ffffff'
                      : (resList[i].taskList.length > 0
                          ? '#CF241C'
                          : '#333333'))),
            ),
          ),
        ),
      ));
    }
    return list;
  }

  List<Widget> _buildWeeks(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < weeks.length; i++) {
      list.add(GestureDetector(
        child: Container(
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setHeight(56),
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              fit: BoxFit.contain,
//              image: AssetImage('lib/images/date1.png'),
//            ),
//          ),
          child: Center(
            child: Text(
              '${weeks[i]}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: ColorUtil.color('#666666')),
            ),
          ),
        ),
      ));
    }
    return list;
  }

  List<Widget> _planBuild(BuildContext context) {
    DateTime d1 =
        DateTime(currentDate.year, currentDate.month, currentDay).toUtc();
    DateTime d2 =
        DateTime.parse("${DateTime.now().toString().substring(0, 19)}-0800");
    var difference = d1.difference(d2);
    bool showEdit = difference.inDays >= 0 ? true : false;
    List<Widget> list = [];
    for (int i = 0; i < planList.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(24),
            ScreenUtil().setHeight(10),
            ScreenUtil().setWidth(12),
            ScreenUtil().setHeight(10)),
        decoration: BoxDecoration(
          color: ColorUtil.color('#ffffff'),
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(26))),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              child: Image.network(
                '${planList[i].baseUrl!=null?planList[i].baseUrl+planList[i].cleanerProfile:''}',
                width: ScreenUtil().setWidth(152),
                height: ScreenUtil().setHeight(152),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${planList[i].cleanerName}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(32),
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
                          color: ColorUtil.color('#F2F2F2'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Text('${planList[i].title}',
                            style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.bold)),
                      ),
                      Text('${planList[i].startTime}-${planList[i].endTime}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ],
                  ),
                  Offstage(
                    offstage: !showEdit,
                    child: Container(
                      width: ScreenUtil().setWidth(136),
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(0),
                            ScreenUtil().setHeight(12),
                            ScreenUtil().setWidth(0),
                            ScreenUtil().setHeight(12)),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: ColorUtil.color('#CF241C'),
                              width: ScreenUtil().setWidth(1),
                            ),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(60))),
                        color: ColorUtil.color('#ffffff'),
                        child: Text('调整',
                            style: TextStyle(
                              color: ColorUtil.color('#CF241C'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                        onPressed: () {
                          String day = currentDay >= 10
                              ? currentDay.toString()
                              : '0' + currentDay.toString();
                          String sendDate = dateStr + '-' + day;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckSchedulingEdit(
                                    id: planList[i].id, dateStr: sendDate),
                              )).then((data) {
                            if (data == 'init') {
                              print('刷新list');
                              setState(() {
                                currentDay = 0;
                                planList = [];
                              });
                              _getDataList();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ));
    }
    return list;
  }
}

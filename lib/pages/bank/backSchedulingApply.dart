import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackSchedulingApply extends StatefulWidget {
  final int outId;
  final String outStr;

  const BackSchedulingApply({Key key, this.outId, this.outStr})
      : super(key: key);

  @override
  _BackSchedulingApplyState createState() => _BackSchedulingApplyState();
}

/// 银行人员
class _BackSchedulingApplyState extends State<BackSchedulingApply>
    with ComPageWidget {
  String dateStr = '';
  DateTime currentDate = new DateTime.now();
  String startDateStr = '';
  DateTime startDate = new DateTime.now();
  String endDateStr = '';
  DateTime endDate = new DateTime.now();
  String hours = "";
  String minute = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '排班申请',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        // 默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[

                          /// 头部
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(0)),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text('网点：${widget.outStr}',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize: ScreenUtil()
                                                        .setSp(36),
                                                    fontWeight: FontWeight
                                                        .bold))),
                                      ],
                                    )),
                              ],
                            ),
                          ),

                          /// 排班日期
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(0)),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      ResetPicker.showDatePicker(context,
                                          value: currentDate,
                                          dateType: DateType.YMD,
                                          minValue: DateTime.now(),
//                            maxValue: DateTime(today.year + 1,today.month,today.day),
                                          title: '选择日期',
                                          clickCallback: (timeStr, time) {
                                            print(timeStr);
                                            setState(() {
                                              dateStr = timeStr;
                                              currentDate =
                                                  DateTime.parse(time);
                                            });
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text('排班日期',
                                                style: TextStyle(
                                                    color:
                                                    ColorUtil.color('#333333'),
                                                    fontSize:
                                                    ScreenUtil().setSp(36),
                                                    fontWeight: FontWeight
                                                        .bold))),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                                dateStr == '' ? '请选择' : dateStr,
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize: ScreenUtil().setSp(
                                                      32),
                                                )),
                                            Container(
                                              width: ScreenUtil().setWidth(32),
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil().setWidth(
                                                      24)),
                                              child: Image.asset(
                                                  'lib/images/clean/sel_right.png'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(0)),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                            ),
                            child: Column(
                              children: <Widget>[

                                /// 开始时间
                                GestureDetector(
                                    onTap: () {
                                      ResetPicker.showDatePicker(context,
                                          value: startDate,
                                          dateType: DateType.kHM,
//                                          minValue: currentDate,
//                                          maxValue: endDate,
                                          title: '选择开始时间',
                                          clickCallback: (timeStr, time) {
                                            setState(() {
                                              startDateStr = timeStr;
                                              startDate = DateTime.parse(time);
                                            });
                                            _getDuration();
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text('开始时间',
                                                style: TextStyle(
                                                    color:
                                                    ColorUtil.color('#333333'),
                                                    fontSize:
                                                    ScreenUtil().setSp(36),
                                                    fontWeight: FontWeight
                                                        .bold))),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                                startDateStr == ""
                                                    ? '请选择'
                                                    : startDateStr,
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize: ScreenUtil().setSp(
                                                      32),
                                                )),
                                            Container(
                                              width: ScreenUtil().setWidth(32),
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil().setWidth(
                                                      24)),
                                              child: Image.asset(
                                                  'lib/images/clean/sel_right.png'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),

                                /// 结束时间
                                GestureDetector(
                                    onTap: () {
                                      if (startDateStr == "")
                                        return showToast('请选择开始时间');
                                      ResetPicker.showDatePicker(context,
                                          value: endDate,
                                          dateType: DateType.kHM,
//                                          minValue: startDate,
//                            maxValue: DateTime(today.year + 1,today.month,today.day),
                                          title: '选择结束时间',
                                          clickCallback: (timeStr, time) {
                                            setState(() {
                                              endDateStr = timeStr;
                                              endDate = DateTime.parse(time);
                                            });
                                            _getDuration();
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(50)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              child: Text('结束时间',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize:
                                                      ScreenUtil().setSp(36),
                                                      fontWeight:
                                                      FontWeight.bold))),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                  endDateStr == ""
                                                      ? '请选择'
                                                      : endDateStr,
                                                  style: TextStyle(
                                                    color:
                                                    ColorUtil.color('#666666'),
                                                    fontSize:
                                                    ScreenUtil().setSp(32),
                                                  )),
                                              Container(
                                                width: ScreenUtil().setWidth(
                                                    32),
                                                margin: EdgeInsets.only(
                                                    left:
                                                    ScreenUtil().setWidth(24)),
                                                child: Image.asset(
                                                    'lib/images/clean/sel_right.png'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),

                                /// 时长
                                GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(50)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              child: Text('时长',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize:
                                                      ScreenUtil().setSp(36),
                                                      fontWeight:
                                                      FontWeight.bold))),
                                          Offstage(
                                            offstage: startDateStr == "" ||
                                                endDateStr == "",
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: '${hours}',
                                                      style: TextStyle(
                                                          color: ColorUtil
                                                              .color(
                                                              '#CF241C'),
                                                          fontSize:
                                                          ScreenUtil().setSp(
                                                              36),
                                                          fontWeight: FontWeight
                                                              .bold)),
                                                  TextSpan(
                                                      text: '小时',
                                                      style: TextStyle(
                                                        color:
                                                        ColorUtil.color(
                                                            '#333333'),
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize:
                                                        ScreenUtil().setSp(36),
                                                      )),
                                                  TextSpan(
                                                      text: ' ${minute}',
                                                      style: TextStyle(
                                                          color: ColorUtil
                                                              .color(
                                                              '#CF241C'),
                                                          fontSize:
                                                          ScreenUtil().setSp(
                                                              36),
                                                          fontWeight: FontWeight
                                                              .bold)),
                                                  TextSpan(
                                                      text: '分',
                                                      style: TextStyle(
                                                        color:
                                                        ColorUtil.color(
                                                            '#333333'),
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize:
                                                        ScreenUtil().setSp(36),
                                                      )),
                                                ])),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
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
                  borderRadius:
                  BorderRadius.circular(ScreenUtil().setWidth(60))),
              color: ColorUtil.color('#CF241C'),
              child: Text('提交',
                  style: TextStyle(
                    color: ColorUtil.color('#ffffff'),
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(32),
                  )),
              disabledColor: ColorUtil.color('#E1E1E1'),

              /// _isDisabled
              onPressed: false
                  ? null
                  : () {
                _submitFrom();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.outId);
    print(widget.outStr);
  }

  Future _submitFrom() async {
    if(dateStr=="") return showToast('请选择日期');
    if(startDateStr=="") return showToast('请开始时间');
    if(endDateStr=="") return showToast('请结束时间');
    Map params = new Map();
    params['dateStr'] = dateStr;
    params['startTimeStr'] = startDateStr;
    params['endTimeStr'] = endDateStr;
    params['orgBranchId'] = widget.outId;
    Api.taskRequestCreate(map:params).then((res) {
        if(res.code==1){
          Navigator.of(context).pop('init');
        }
        showToast(res.msg);
    });
  }


  void _getDuration() {
    if (startDateStr == "") return;
    if (endDateStr == "") return;
    print(startDateStr);
    print(endDateStr);
    List<int> start = [];
    List<int> end = [];
    startDateStr.split(':').forEach((val) {
      start.add(int.parse(val));
    });
    endDateStr.split(':').forEach((val) {
      end.add(int.parse(val));
    });
    if (end[1] - start[1] < 0) {
      end[0] = end[0] - 1 - start[0];
      end[1] = end[1] + 60 - start[1];
    } else {
      end[0] -= start[0];
      end[1] -= start[1];
    }
    setState(() {
      hours = '${end[0]}';
      minute = '${end[1]}';
    });
  }
}

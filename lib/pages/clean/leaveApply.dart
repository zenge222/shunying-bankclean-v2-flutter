import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LeaveApply extends StatefulWidget {
  @override
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply> with ComPageWidget {
  bool isLoading = false;
  FocusNode blankNode = FocusNode();
  String reason = '';
  String leaveTypeStr = ''; // 请假类型
  int leaveTypeIndex = 0; // 请假类型索引
  // 开始日期
  String startDate = "";
  DateTime dateStart = DateTime.now();

//  int startTime = 0;
  String startTimeStr = '';

  // 结束日期
  String endDate = "";
  DateTime dateEnd = DateTime.now();
  DateTime bindEnd = DateTime.now();

//  int endTime = 0;
  String endTimeStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '请假申请',
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
        child: GestureDetector(
          onTap: () {
            // 点击空白页面关闭键盘
            FocusScope.of(context).requestFocus(blankNode);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
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
                                var aa = [
                                  '病假',
                                  '事假',
                                  '年假',
                                ];
                                ResetPicker.showStringPicker(context,
                                    data: aa,
                                    normalIndex: leaveTypeIndex,
                                    title: "选择原因",
                                    clickCallBack: (int index, var str) {
                                  print(index);
//                                        print(str);
                                  setState(() {
                                    leaveTypeStr = str;
                                    leaveTypeIndex = index;
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Text('请假类型',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold))),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                          leaveTypeStr == ''
                                              ? '请选择'
                                              : leaveTypeStr,
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          )),
                                      Container(
                                        width: ScreenUtil().setWidth(32),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(24)),
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
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
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
                              /// 选择时段
                              List<String> aa = ['上午', '下午'];
                              ResetPicker.showStringPicker(context,
                                  data: aa, normalIndex: 0, title: "请选择时段",
                                  clickCallBack: (int index, var str) {
                                setState(() {
                                  startTimeStr = str;
                                });
                              });

                              /// 日期选择器
                              ResetPicker.showDatePicker(context,
                                  dateType: DateType.YMD,
                                  minValue: DateTime.now(),
                                  value: dateStart,
                                  clickCallback: (var str, var time) {
                                setState(() {
                                  startDate = str;
                                  dateStart = DateTime.parse(time);
                                  bindEnd = DateTime.parse(time);
                                });
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Text('开始时间',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      startDate == ""
                                          ? '请选择'
                                          : startDate +
                                              (startTimeStr == ""
                                                  ? ''
                                                  : startTimeStr),
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(32),
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(24)),
                                      child: Image.asset(
                                          'lib/images/clean/sel_right.png'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(50)),
                            child: GestureDetector(
                              onTap: () {
                                if (startDate == "") {
                                  showToast('请选择开始时间');
                                }else {
                                  /// 选择时段
                                  List<String> aa = ['上午', '下午'];
                                  ResetPicker.showStringPicker(context,
                                      data: aa, normalIndex: 0, title: "请选择时段",
                                      clickCallBack: (int index, var str) {
                                    setState(() {
                                      endTimeStr = str;
                                    });
                                  });

                                  /// 日期选择器
                                  ResetPicker.showDatePicker(context,
                                      dateType: DateType.YMD,
                                      minValue: dateStart,
//                                    maxValue: dateStart,
                                      value: dateEnd,
                                      clickCallback: (var str, var time) {
                                    print(startDate);
                                    setState(() {
                                      endDate = str;
                                      dateEnd = DateTime.parse(time);
                                    });
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Text('结束时间',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold))),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        endDate == ""
                                            ? '请选择'
                                            : endDate +
                                                (endTimeStr == ""
                                                    ? ''
                                                    : endTimeStr),
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(32),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(24)),
                                        child: Image.asset(
                                            'lib/images/clean/sel_right.png'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(8)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('请假原因',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Material(
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(50)),
                              child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      reason = text;
                                    });
                                  },
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: ColorUtil.color('#333333'),
                                      textBaseline: TextBaseline.alphabetic),
                                  decoration: InputDecoration(
                                    fillColor: ColorUtil.color('#F5F6F9'),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(
                                      ScreenUtil().setSp(20),
                                    ),
                                    hintText: "请输入原因",
                                    border: InputBorder.none,
                                    hasFloatingPlaceholder: false,
                                  )),
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
                  onPressed: () {
                    _submitLeaveApply();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _submitLeaveApply() async {
    if (leaveTypeStr == "") return showToast('请选择请假类型');
    if (startDate == "") return showToast('请选择开始日期');
    if (startTimeStr == "") return showToast('请选择开始时段');
    if (endDate == "") return showToast('请选择结束日期');
    if (endTimeStr == "") return showToast('请选择结束时段');
    if (reason == "") return showToast('请填写请假理由');
    Map params = new Map();
    int type = leaveTypeIndex + 1;
    params['type'] = type;
    params['reason'] = reason;
    params['startDate'] = startDate;
    params['startTime'] = startTimeStr == "上午" ? 1 : 2;
    params['endDate'] = endDate;
    params['endTime'] = endTimeStr == "上午" ? 1 : 2;
    Api.submitLeaveApply(map: params).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
        showToast('申请提交成功');
      }else{
        showToast(res.msg);
      }
    });
  }
}

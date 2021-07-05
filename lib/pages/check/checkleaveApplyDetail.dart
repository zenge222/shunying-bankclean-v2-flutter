import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/materialApplyVO.dart';
import 'package:bank_clean_flutter/models/workOffApplyVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielSelect.dart';
import 'package:bank_clean_flutter/pages/common/cleanSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CheckLeaveApplyDetail extends StatefulWidget {
  final int id;

  const CheckLeaveApplyDetail({Key key, this.id}) : super(key: key);

  @override
  _CheckLeaveApplyDetailState createState() => _CheckLeaveApplyDetailState();
}

/// 区域经理
class _CheckLeaveApplyDetailState extends State<CheckLeaveApplyDetail>
    with ComPageWidget {
  bool isLoading = false;

//  MaterialApplyVO resData;
  WorkOffApplyVO resData;
  int valetId = 0;
  String valetStr = '';
  String content = '';

  /// 1:通过，2拒绝
  int submitType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '请假申请详情',
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
        child: resData != null
            ? Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(24),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(24)),
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(40),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(40)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('请假申请',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(10),
                                              ScreenUtil().setHeight(2),
                                              ScreenUtil().setWidth(10),
                                              ScreenUtil().setHeight(2)),
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(26)),
                                          decoration: BoxDecoration(
                                            color: ColorUtil.color(
                                                resData.status == 1
                                                    ? '#FFF4EC'
                                                    : (resData.status == 2
                                                        ? '#ECF1FF'
                                                        : '#F2F2F2')),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setWidth(8))),
                                          ),
                                          child: Text(
                                              resData.status == 1
                                                  ? '待审核'
                                                  : (resData.status == 2
                                                      ? '已通过'
                                                      : '未通过'),
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      resData.status == 1
                                                          ? '#CD8E5F'
                                                          : (resData.status == 2
                                                              ? '#375ECC'
                                                              : '#666666')),
                                                  fontSize:
                                                      ScreenUtil().setSp(28),
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                    Text('${resData.createTime}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请人：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.cleanerName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '所在网点：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.organizationBranchName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '请假类型：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.typeText}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '请假时间：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          '${resData.startDate}${resData.startTimeText}-${resData.endDate}${resData.endTimeText}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(31),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请原因：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.reason}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                            ],
                          ),
                        ),

                        /// 审批
                        Offstage(
                          offstage: resData.status == 1,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24)),
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('审批',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${resData.areaManagerName}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          )),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(10),
                                            ScreenUtil().setHeight(2),
                                            ScreenUtil().setWidth(10),
                                            ScreenUtil().setHeight(2)),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(26)),
                                        decoration: BoxDecoration(
                                          color: ColorUtil.color(
                                              resData.status == 2
                                                  ? '#ECF1FF'
                                                  : '#f2f2f2'),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setWidth(8))),
                                        ),
                                        child: Text(
                                            resData.status == 2 ? '已通过' : '未通过',
                                            style: TextStyle(
                                                color: ColorUtil.color(
                                                    resData.status == 2
                                                        ? '#375ECC'
                                                        : '#666666'),
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        /// 代班安排
                        Offstage(
                          offstage: resData.status == 3,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24)),
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('代班安排',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('代班人',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          )),
                                      resData.status == 1
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CleanSelect(
                                                        id: widget.id,
                                                        type: 2,
                                                        feedbackId: resData.id,
                                                      ),
                                                    )).then((data) {
                                                  if (data != null) {
                                                    print('改变数据');
                                                    setState(() {
                                                      valetId = data.id;
                                                      valetStr = data.name;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      valetStr == ''
                                                          ? '请选择'
                                                          : valetStr,
                                                      style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#666666'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(32),
                                                      )),
                                                  Container(
                                                    width: ScreenUtil()
                                                        .setWidth(32),
                                                    margin: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(24)),
                                                    child: Image.asset(
                                                        'lib/images/clean/sel_right.png'),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Text(
                                              '${resData.insteadCleanerName}',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#666666'),
                                                fontSize:
                                                    ScreenUtil().setSp(32),
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
                  )),
                  Offstage(
                    offstage: resData.status != 1,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(16),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(16)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(13)),
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(20),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(20)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(60))),
                              color: ColorUtil.color('#EAEAEA'),
                              child: Text('拒绝',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                setState(() {
                                  submitType = 2;
                                });
                                showCustomDialog(context, '确定拒绝', (){
                                  _submitDetail(context);
                                });

                              },
                            ),
                          )),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(13)),
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
                              child: Text('通过',
                                  style: TextStyle(
                                    color: ColorUtil.color('#ffffff'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                setState(() {
                                  submitType = 1;
                                });
                                _submitDetail(context);
                              },
                            ),
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Text(''),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _getData();
  }

//  Future _getData() async {
//    Map params = new Map();
//    params['id'] = widget.id;
//    Api.getMaterialDetail(map: params).then((res) {
//      if (res.code == 1) {
//        setState(() {
//          isLoading = false;
//          resData = res.data;
//        });
//      } else {
//        showToast(res.msg);
//      }
//    });
//  }

  Future _getData() async {
    Map params = new Map();
    params['id'] = widget.id;
    Api.getLeaveApplyDetail(map: params).then((res) {
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

  Future _submitDetail(BuildContext context) async {
    // if (submitType == 1) {
    //   if (valetId == 0) {
    //     return showToast('请选择代班人');
    //   }
    // }
    Map params = new Map();
    params['id'] = widget.id;
    params['insteadCleanId'] = valetId;
    if (submitType == 2) {
      params['rejectReason'] = content;
    }
    params['status'] = submitType;
    Api.auditLeaveApply(map: params).then((res) {
      if (res.code == 1) {
        if (submitType == 2) {
          Navigator.pop(context);
        }
        Navigator.pop(context, 'init');
      }
      showToast(res.msg);
    });
  }

  void _refuse(BuildContext context) {
    showDialog<Null>(
        context: context,
        // 点击背景区域是否可以关闭
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: ScreenUtil().setWidth(600),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#FDFAFE'),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          bottom: ScreenUtil().setHeight(20)),
                      child: Text(
                        '拒绝原因',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(36),
                            color: Color.fromRGBO(0, 0, 0, 0.8)),
                      ),
                    ),

                    /// 详情
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(24),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(24),
                          ScreenUtil().setHeight(0)),
                      decoration: BoxDecoration(
                        color: ColorUtil.color('#F5F6F9'),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(8))),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            child: Container(
                              width: double.infinity,
                              child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      content = text;
                                    });
                                  },
                                  inputFormatters: <TextInputFormatter>[
//                                    WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                                    LengthLimitingTextInputFormatter(300)
                                    //限制长度
                                  ],
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      textBaseline: TextBaseline.alphabetic),
                                  decoration: InputDecoration(
                                    fillColor: ColorUtil.color('#F5F6F9'),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(
                                      ScreenUtil().setSp(20),
                                    ),
                                    hintText: "请输入拒绝原因",
                                    border: InputBorder.none,
                                    hasFloatingPlaceholder: false,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),

                    /// 底部操作
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: ColorUtil.color('#ededed'))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#EAEAEA'),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        ScreenUtil().setWidth(14))),
                              ),
                              child: OutlineButton(
                                onPressed: () async {
                                  Application.router.pop(context);
                                },
                                borderSide: BorderSide.none,
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: ColorUtil.color('#333333')),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#CF241C'),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        ScreenUtil().setWidth(14))),
                              ),
                              child: OutlineButton(
                                onPressed: () async {
                                  if (content == "")
                                    return showToast('请输入拒绝理由');
                                  setState(() {
                                    submitType = 2;
                                  });
                                  _submitDetail(context);
                                },
                                borderSide: BorderSide.none,
                                child: Text(
                                  '确定',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: ColorUtil.color('#ffffff')),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

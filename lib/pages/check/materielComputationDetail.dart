import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/materialApplyVO.dart';
import 'package:bank_clean_flutter/models/toolsCheckRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';

class MaterielComputationDetail extends StatefulWidget {
  final int id;

  const MaterielComputationDetail({Key key, this.id}) : super(key: key);

  @override
  _MaterielComputationDetailState createState() =>
      _MaterielComputationDetailState();
}

class _MaterielComputationDetailState extends State<MaterielComputationDetail>
    with ComPageWidget {
  bool isLoading = false;
  ToolsCheckRecordVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料单详情',
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
                                    Text('${resData.title}',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2),
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2)),
                                      decoration: BoxDecoration(
                                        color: ColorUtil.color(resData.status == 1
                                            ? '#FFE7E6'
                                            : (resData.status == 2 ? '#FFF4EC' : (resData.status==3?'#ECF1FF':'#f2f2f2'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text(
                                          resData.status == 1
                                              ? '待审批'
                                              : (resData.status == 2 ? '已审批' : (resData.status==3?'已发放':'已失效')),
                                          style: TextStyle(
                                              color: ColorUtil.color(resData.status == 1
                                                  ? '#CF241C'
                                                  : (resData.status == 2
                                                      ? '#CD8E5F'
                                                      : (resData.status==3?'#375ECC':'#666666'))),
                                              fontSize: ScreenUtil().setSp(28),
                                              fontWeight: FontWeight.bold)),
                                    )
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
                                      text: '${resData.areaManagerName}',
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
                                      text: '申请时间：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.createTime}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                  Text('物料清单',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold)),
                                  Offstage(
                                    offstage: resData.status != 2,
                                    child: Text('审核通过',
                                        style: TextStyle(
                                            color: ColorUtil.color('#CF241C'),
                                            fontSize: ScreenUtil().setSp(28),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Column(
                                children: materielItems(),
                              )
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: false,
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
                                    Text('驳回原因',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(32)),
                                  child: Text(
                                      '${resData.reason}',
                                      style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                   )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: false,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20)),
                      child:  RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '总计成本：',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(24),
                                )),
                            TextSpan(
                                text: '¥${resData.sumCost}',
                                style: TextStyle(
                                  color: ColorUtil.color('#CF241C'),
                                  fontSize: ScreenUtil().setSp(36),
                                )),
                          ])),
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
    super.initState();
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['id'] = widget.id;
    Api.toolsCheckRecordDetail(map: params).then((res) {
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

  List<Widget> materielItems() {
    List<Widget> widgets = [];
    if (resData.itemList != null) {
      resData.itemList.forEach((val) {
        widgets.add(Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#F5F6F9'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('扫把',
                            style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        Offstage(
                          offstage: false,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(6),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(6),
                                ScreenUtil().setHeight(0)),
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(14)),
                            decoration: BoxDecoration(
                              color: ColorUtil.color('#CF241C'),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(4))),
                            ),
                            child: Text('超额',
                                style: TextStyle(
                                  color: ColorUtil.color('#ffffff'),
                                  fontSize: ScreenUtil().setSp(24),
                                )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('x3',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(32),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      });
    }
    return widgets;
  }

  Future confirmModify() async {
    Map params = new Map();
    params['id'] = resData.id;
    Api.confirmMaterialApply(map: params).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      }
      showToast(res.msg);
    });
  }
}
